/*
 * Souffle - A Datalog Compiler
 * Copyright (c) 2015, Oracle and/or its affiliates. All rights reserved
 * Licensed under the Universal Permissive License v 1.0 as shown at:
 * - https://opensource.org/licenses/UPL
 * - <souffle root>/licenses/SOUFFLE-UPL.txt
 */

/************************************************************************
 *
 * @file AstTransforms.cpp
 *
 * Implementation of AST transformation passes.
 *
 ***********************************************************************/

#include "AstTransforms.h"
#include "AstAttribute.h"
#include "AstClause.h"
#include "AstGroundAnalysis.h"
#include "AstLiteral.h"
#include "AstNode.h"
#include "AstProgram.h"
#include "AstRelation.h"
#include "AstRelationIdentifier.h"
#include "AstTypeAnalysis.h"
#include "AstTypeEnvironmentAnalysis.h"
#include "AstTypes.h"
#include "AstUtils.h"
#include "AstVisitor.h"
#include "BinaryConstraintOps.h"
#include "GraphUtils.h"
#include "PrecedenceGraph.h"
#include "TypeSystem.h"
#include <cstddef>
#include <functional>
#include <map>
#include <memory>
#include <ostream>
#include <set>

namespace souffle {

bool NullTransformer::transform(AstTranslationUnit& translationUnit) {
    return false;
}

bool PipelineTransformer::transform(AstTranslationUnit& translationUnit) {
    bool changed = false;
    for (auto& transformer : pipeline) {
        changed |= applySubtransformer(translationUnit, transformer.get());
    }
    return changed;
}

bool ConditionalTransformer::transform(AstTranslationUnit& translationUnit) {
    return condition() ? applySubtransformer(translationUnit, transformer.get()) : false;
}

bool WhileTransformer::transform(AstTranslationUnit& translationUnit) {
    bool changed = false;
    while (condition()) {
        changed |= applySubtransformer(translationUnit, transformer.get());
    }
    return changed;
}

bool FixpointTransformer::transform(AstTranslationUnit& translationUnit) {
    bool changed = false;
    while (applySubtransformer(translationUnit, transformer.get())) {
        changed = true;
    }
    return changed;
}

bool RemoveRelationCopiesTransformer::removeRelationCopies(AstTranslationUnit& translationUnit) {
    using alias_map = std::map<AstRelationIdentifier, AstRelationIdentifier>;

    // tests whether something is a variable
    auto isVar = [&](const AstArgument& arg) { return dynamic_cast<const AstVariable*>(&arg); };

    // tests whether something is a record
    auto isRec = [&](const AstArgument& arg) { return dynamic_cast<const AstRecordInit*>(&arg); };

    // collect aliases
    alias_map isDirectAliasOf;

    auto* ioType = translationUnit.getAnalysis<IOType>();

    AstProgram& program = *translationUnit.getProgram();

    // search for relations only defined by a single rule ..
    for (AstRelation* rel : program.getRelations()) {
        if (!ioType->isIO(rel) && rel->getClauses().size() == 1u) {
            // .. of shape r(x,y,..) :- s(x,y,..)
            AstClause* cl = rel->getClause(0);
            if (!cl->isFact() && cl->getBodySize() == 1u && cl->getAtoms().size() == 1u) {
                AstAtom* atom = cl->getAtoms()[0];
                if (equal_targets(cl->getHead()->getArguments(), atom->getArguments())) {
                    // we have a match but have to check that all arguments are either
                    // variables or records containing variables
                    bool onlyVars = true;
                    auto args = cl->getHead()->getArguments();
                    while (!args.empty()) {
                        const auto& cur = args.back();
                        args.pop_back();
                        if (!isVar(*cur)) {
                            if (isRec(*cur)) {
                                // records are decomposed and their arguments are checked
                                const auto& rec_args = static_cast<const AstRecordInit&>(*cur).getArguments();
                                for (auto rec_arg : rec_args) {
                                    args.push_back(rec_arg);
                                }
                            } else {
                                onlyVars = false;
                                break;
                            }
                        }
                    }
                    if (onlyVars) {
                        // all arguments are either variables or records containing variables
                        isDirectAliasOf[cl->getHead()->getName()] = atom->getName();
                    }
                }
            }
        }
    }

    // map each relation to its ultimate alias (could be transitive)
    alias_map isAliasOf;

    // track any copy cycles; cyclic rules are effectively empty
    std::set<AstRelationIdentifier> cycle_reps;

    for (std::pair<AstRelationIdentifier, AstRelationIdentifier> cur : isDirectAliasOf) {
        // compute replacement

        std::set<AstRelationIdentifier> visited;
        visited.insert(cur.first);
        visited.insert(cur.second);

        auto pos = isDirectAliasOf.find(cur.second);
        while (pos != isDirectAliasOf.end()) {
            if (visited.count(pos->second)) {
                cycle_reps.insert(cur.second);
                break;
            }
            cur.second = pos->second;
            pos = isDirectAliasOf.find(cur.second);
        }
        isAliasOf[cur.first] = cur.second;
    }

    if (isAliasOf.empty()) {
        return false;
    }

    // replace usage of relations according to alias map
    visitDepthFirst(program, [&](const AstAtom& atom) {
        auto pos = isAliasOf.find(atom.getName());
        if (pos != isAliasOf.end()) {
            const_cast<AstAtom&>(atom).setName(pos->second);
        }
    });

    // break remaining cycles
    for (const auto& rep : cycle_reps) {
        auto rel = program.getRelation(rep);
        rel->removeClause(rel->getClause(0));
    }

    // remove unused relations
    for (const auto& cur : isAliasOf) {
        if (!cycle_reps.count(cur.first)) {
            program.removeRelation(program.getRelation(cur.first)->getName());
        }
    }

    return true;
}

bool UniqueAggregationVariablesTransformer::transform(AstTranslationUnit& translationUnit) {
    bool changed = false;

    // make variables in aggregates unique
    int aggNumber = 0;
    visitDepthFirstPostOrder(*translationUnit.getProgram(), [&](const AstAggregator& agg) {
        // only applicable for aggregates with target expression
        if (!agg.getTargetExpression()) {
            return;
        }

        // get all variables in the target expression
        std::set<std::string> names;
        visitDepthFirst(
                *agg.getTargetExpression(), [&](const AstVariable& var) { names.insert(var.getName()); });

        // rename them
        visitDepthFirst(agg, [&](const AstVariable& var) {
            auto pos = names.find(var.getName());
            if (pos == names.end()) {
                return;
            }
            const_cast<AstVariable&>(var).setName(" " + var.getName() + toString(aggNumber));
            changed = true;
        });

        // increment aggregation number
        aggNumber++;
    });
    return changed;
}

bool MaterializeAggregationQueriesTransformer::materializeAggregationQueries(
        AstTranslationUnit& translationUnit) {
    bool changed = false;

    AstProgram& program = *translationUnit.getProgram();
    const TypeEnvironment& env = translationUnit.getAnalysis<TypeEnvironmentAnalysis>()->getTypeEnvironment();

    // if an aggregator has a body consisting of more than an atom => create new relation
    int counter = 0;
    visitDepthFirst(program, [&](const AstClause& clause) {
        visitDepthFirst(clause, [&](const AstAggregator& agg) {
            // check whether a materialization is required
            if (!needsMaterializedRelation(agg)) {
                return;
            }
            changed = true;

            // -- create a new clause --

            auto relName = "__agg_rel_" + toString(counter++);
            while (program.getRelation(relName) != nullptr) {
                relName = "__agg_rel_" + toString(counter++);
            }
            // create the new clause for the materialised thing
            auto* aggClause = new AstClause();
            // create the body of the new thing
            for (const auto& cur : agg.getBodyLiterals()) {
                aggClause->addToBody(std::unique_ptr<AstLiteral>(cur->clone()));
            }
            // find stuff for which we need a grounding
            for (const auto& argPair : getGroundedTerms(*aggClause)) {
                const auto* variable = dynamic_cast<const AstVariable*>(argPair.first);
                bool variableIsGrounded = argPair.second;
                // if it's not even a variable type or the term is grounded
                // then skip it
                if (variable == nullptr || variableIsGrounded) {
                    continue;
                }

                for (const auto& lit : clause.getBodyLiterals()) {
                    const auto* atom = dynamic_cast<const AstAtom*>(lit);
                    if (atom == nullptr) {
                        continue;  // ignore these because they can't ground the variable
                    }
                    for (const auto& arg : atom->getArguments()) {
                        const auto* atomVariable = dynamic_cast<const AstVariable*>(arg);
                        // if this atom contains the variable I need to ground, add it
                        if (atomVariable && variable->getName() == atomVariable->getName()) {
                            // expand the body with this one so that it will ground this variable
                            aggClause->addToBody(std::unique_ptr<AstLiteral>(atom->clone()));
                            break;
                        }
                    }
                }
            }

            auto* head = new AstAtom();
            head->setName(relName);
            std::vector<bool> symbolArguments;

            // Ensure each variable is only added once
            std::set<std::string> variables;
            visitDepthFirst(*aggClause, [&](const AstVariable& var) { variables.insert(var.getName()); });

            // Insert all variables occurring in the body of the aggregate into the head
            for (const auto& var : variables) {
                head->addArgument(std::make_unique<AstVariable>(var));
            }

            aggClause->setHead(std::unique_ptr<AstAtom>(head));

            // instantiate unnamed variables in count operations
            if (agg.getOperator() == AstAggregator::count) {
                int count = 0;
                for (const auto& cur : aggClause->getBodyLiterals()) {
                    cur->apply(makeLambdaAstMapper(
                            [&](std::unique_ptr<AstNode> node) -> std::unique_ptr<AstNode> {
                                // check whether it is a unnamed variable
                                auto* var = dynamic_cast<AstUnnamedVariable*>(node.get());
                                if (!var) {
                                    return node;
                                }

                                // replace by variable
                                auto name = " _" + toString(count++);
                                auto res = new AstVariable(name);

                                // extend head
                                head->addArgument(std::unique_ptr<AstArgument>(res->clone()));

                                // return replacement
                                return std::unique_ptr<AstNode>(res);
                            }));
                }
            }

            // -- build relation --

            auto* rel = new AstRelation();
            rel->setName(relName);
            // add attributes
            std::map<const AstArgument*, TypeSet> argTypes =
                    TypeAnalysis::analyseTypes(env, *aggClause, &program);
            for (const auto& cur : head->getArguments()) {
                rel->addAttribute(std::make_unique<AstAttribute>(
                        toString(*cur), (isNumberType(argTypes[cur])) ? "number" : "symbol"));
            }

            rel->addClause(std::unique_ptr<AstClause>(aggClause));
            program.appendRelation(std::unique_ptr<AstRelation>(rel));

            // -- update aggregate --
            AstAtom* aggAtom = head->clone();

            // count the usage of variables in the clause
            // outside of aggregates. Note that the visitor
            // is exhaustive hence double counting occurs
            // which needs to be deducted for variables inside
            // the aggregators and variables in the expression
            // of aggregate need to be added. Counter is zero
            // if the variable is local to the aggregate
            std::map<std::string, int> varCtr;
            visitDepthFirst(clause, [&](const AstArgument& arg) {
                if (const auto* a = dynamic_cast<const AstAggregator*>(&arg)) {
                    visitDepthFirst(arg, [&](const AstVariable& var) { varCtr[var.getName()]--; });
                    if (a->getTargetExpression() != nullptr) {
                        visitDepthFirst(*a->getTargetExpression(),
                                [&](const AstVariable& var) { varCtr[var.getName()]++; });
                    }
                } else {
                    visitDepthFirst(arg, [&](const AstVariable& var) { varCtr[var.getName()]++; });
                }
            });
            for (size_t i = 0; i < aggAtom->getArity(); i++) {
                if (auto* var = dynamic_cast<AstVariable*>(aggAtom->getArgument(i))) {
                    // replace local variable by underscore if local
                    if (varCtr[var->getName()] == 0) {
                        aggAtom->setArgument(i, std::make_unique<AstUnnamedVariable>());
                    }
                }
            }
            const_cast<AstAggregator&>(agg).clearBodyLiterals();
            const_cast<AstAggregator&>(agg).addBodyLiteral(std::unique_ptr<AstLiteral>(aggAtom));
        });
    });
    return changed;
}

bool MaterializeAggregationQueriesTransformer::needsMaterializedRelation(const AstAggregator& agg) {
    // everything with more than 1 body literal => materialize
    if (agg.getBodyLiterals().size() > 1) {
        return true;
    }

    // inspect remaining atom more closely
    const AstAtom* atom = dynamic_cast<const AstAtom*>(agg.getBodyLiterals()[0]);
    if (!atom) {
        // no atoms, so materialize
        return true;
    }

    // if the same variable occurs several times => materialize
    bool duplicates = false;
    std::set<std::string> vars;
    visitDepthFirst(*atom,
            [&](const AstVariable& var) { duplicates = duplicates | !vars.insert(var.getName()).second; });

    // if there are duplicates a materialization is required
    if (duplicates) {
        return true;
    }

    // for all others the materialization can be skipped
    return false;
}

bool RemoveEmptyRelationsTransformer::removeEmptyRelations(AstTranslationUnit& translationUnit) {
    AstProgram& program = *translationUnit.getProgram();
    auto* ioTypes = translationUnit.getAnalysis<IOType>();
    bool changed = false;
    for (auto rel : program.getRelations()) {
        if (rel->clauseSize() > 0 || ioTypes->isInput(rel)) {
            continue;
        }
        changed |= removeEmptyRelationUses(translationUnit, rel);

        bool usedInAggregate = false;
        visitDepthFirst(program, [&](const AstAggregator& agg) {
            for (const auto lit : agg.getBodyLiterals()) {
                visitDepthFirst(*lit, [&](const AstAtom& atom) {
                    if (getAtomRelation(&atom, &program) == rel) {
                        usedInAggregate = true;
                    }
                });
            }
        });

        if (!usedInAggregate && !ioTypes->isOutput(rel)) {
            program.removeRelation(rel->getName());
            changed = true;
        }
    }
    return changed;
}

bool RemoveEmptyRelationsTransformer::removeEmptyRelationUses(
        AstTranslationUnit& translationUnit, AstRelation* emptyRelation) {
    AstProgram& program = *translationUnit.getProgram();
    bool changed = false;

    //
    // (1) drop rules from the program that have empty relations in their bodies.
    // (2) drop negations of empty relations
    //
    // get all clauses
    std::vector<const AstClause*> clauses;
    visitDepthFirst(program, [&](const AstClause& cur) { clauses.push_back(&cur); });

    // clean all clauses
    for (const AstClause* cl : clauses) {
        // check for an atom whose relation is the empty relation

        bool removed = false;
        for (AstLiteral* lit : cl->getBodyLiterals()) {
            if (auto* arg = dynamic_cast<AstAtom*>(lit)) {
                if (getAtomRelation(arg, &program) == emptyRelation) {
                    program.removeClause(cl);
                    removed = true;
                    changed = true;
                    break;
                }
            }
        }

        if (!removed) {
            // check whether a negation with empty relations exists

            bool rewrite = false;
            for (AstLiteral* lit : cl->getBodyLiterals()) {
                if (auto* neg = dynamic_cast<AstNegation*>(lit)) {
                    if (getAtomRelation(neg->getAtom(), &program) == emptyRelation) {
                        rewrite = true;
                        break;
                    }
                }
            }

            if (rewrite) {
                // clone clause without negation for empty relations

                auto res = std::unique_ptr<AstClause>(cl->cloneHead());

                for (AstLiteral* lit : cl->getBodyLiterals()) {
                    if (auto* neg = dynamic_cast<AstNegation*>(lit)) {
                        if (getAtomRelation(neg->getAtom(), &program) != emptyRelation) {
                            res->addToBody(std::unique_ptr<AstLiteral>(lit->clone()));
                        }
                    } else {
                        res->addToBody(std::unique_ptr<AstLiteral>(lit->clone()));
                    }
                }

                program.removeClause(cl);
                program.appendClause(std::move(res));
                changed = true;
            }
        }
    }

    return changed;
}

bool RemoveRedundantRelationsTransformer::transform(AstTranslationUnit& translationUnit) {
    bool changed = false;
    auto* redundantRelationsAnalysis = translationUnit.getAnalysis<RedundantRelations>();
    const std::set<const AstRelation*>& redundantRelations =
            redundantRelationsAnalysis->getRedundantRelations();
    if (!redundantRelations.empty()) {
        for (auto rel : redundantRelations) {
            translationUnit.getProgram()->removeRelation(rel->getName());
            changed = true;
        }
    }
    return changed;
}

bool RemoveBooleanConstraintsTransformer::transform(AstTranslationUnit& translationUnit) {
    AstProgram& program = *translationUnit.getProgram();

    // If any boolean constraints exist, they will be removed
    bool changed = false;
    visitDepthFirst(program, [&](const AstBooleanConstraint& bc) { changed = true; });

    // Remove true and false constant literals from all aggregators
    struct removeBools : public AstNodeMapper {
        std::unique_ptr<AstNode> operator()(std::unique_ptr<AstNode> node) const override {
            // Remove them from child nodes
            node->apply(*this);

            if (auto* aggr = dynamic_cast<AstAggregator*>(node.get())) {
                bool containsTrue = false;
                bool containsFalse = false;

                for (AstLiteral* lit : aggr->getBodyLiterals()) {
                    if (auto* bc = dynamic_cast<AstBooleanConstraint*>(lit)) {
                        bc->isTrue() ? containsTrue = true : containsFalse = true;
                    }
                }

                if (containsFalse || containsTrue) {
                    // Only keep literals that aren't boolean constraints
                    auto replacementAggregator = std::unique_ptr<AstAggregator>(aggr->clone());
                    replacementAggregator->clearBodyLiterals();

                    bool isEmpty = true;

                    // Don't bother copying over body literals if any are false
                    if (!containsFalse) {
                        for (AstLiteral* lit : aggr->getBodyLiterals()) {
                            // Don't add in 'true' boolean constraints
                            if (!dynamic_cast<AstBooleanConstraint*>(lit)) {
                                isEmpty = false;
                                replacementAggregator->addBodyLiteral(
                                        std::unique_ptr<AstLiteral>(lit->clone()));
                            }
                        }
                    }

                    if (containsFalse || isEmpty) {
                        // Empty aggregator body!
                        // Not currently handled, so add in a false literal in the body
                        // E.g. max x : { } =becomes=> max 1 : {0 = 1}
                        replacementAggregator->setTargetExpression(std::make_unique<AstNumberConstant>(1));

                        // Add '0 = 1' if false was found, '1 = 1' otherwise
                        int lhsConstant = containsFalse ? 0 : 1;
                        replacementAggregator->addBodyLiteral(std::make_unique<AstBinaryConstraint>(
                                BinaryConstraintOp::EQ, std::make_unique<AstNumberConstant>(lhsConstant),
                                std::make_unique<AstNumberConstant>(1)));
                    }

                    return std::move(replacementAggregator);
                }
            }

            // no false or true, so return the original node
            return node;
        }
    };

    removeBools update;
    program.apply(update);

    // Remove true and false constant literals from all clauses
    for (AstRelation* rel : program.getRelations()) {
        for (AstClause* clause : rel->getClauses()) {
            bool containsTrue = false;
            bool containsFalse = false;

            for (AstLiteral* lit : clause->getBodyLiterals()) {
                if (auto* bc = dynamic_cast<AstBooleanConstraint*>(lit)) {
                    bc->isTrue() ? containsTrue = true : containsFalse = true;
                }
            }

            if (containsFalse) {
                // Clause will always fail
                rel->removeClause(clause);
            } else if (containsTrue) {
                auto replacementClause = std::unique_ptr<AstClause>(clause->cloneHead());

                // Only keep non-'true' literals
                for (AstLiteral* lit : clause->getBodyLiterals()) {
                    if (!dynamic_cast<AstBooleanConstraint*>(lit)) {
                        replacementClause->addToBody(std::unique_ptr<AstLiteral>(lit->clone()));
                    }
                }

                rel->removeClause(clause);
                rel->addClause(std::move(replacementClause));
            }
        }
    }

    return changed;
}

bool PartitionBodyLiteralsTransformer::transform(AstTranslationUnit& translationUnit) {
    bool changed = false;
    AstProgram& program = *translationUnit.getProgram();

    /* Process:
     * Go through each clause and construct a variable dependency graph G.
     * The nodes of G are the variables. A path between a and b exists iff
     * a and b appear in a common body literal.
     *
     * Using the graph, we can extract the body literals that are not associated
     * with the arguments in the head atom into new relations. Depending on
     * variable dependencies among these body literals, the literals can
     * be partitioned into multiple separate new propositional clauses.
     *
     * E.g. a(x) <- b(x), c(y), d(y), e(z), f(z). can be transformed into:
     *      - a(x) <- b(x), newrel0(), newrel1().
     *      - newrel0() <- c(y), d(y).
     *      - newrel1() <- e(z), f(z).
     *
     * Note that only one pass through the clauses is needed:
     *  - All arguments in the body literals of the transformed clause cannot be
     *    independent of the head arguments (by construction)
     *  - The new relations holding the disconnected body literals are propositional,
     *    hence having no head arguments, and so the transformation does not apply.
     */

    // Store clauses to add and remove after analysing the program
    std::vector<AstClause*> clausesToAdd;
    std::vector<const AstClause*> clausesToRemove;

    // The transformation is local to each rule, so can visit each independently
    visitDepthFirst(program, [&](const AstClause& clause) {
        // Create the variable dependency graph G
        Graph<std::string> variableGraph = Graph<std::string>();
        std::set<std::string> ruleVariables;

        // Add in the nodes
        // The nodes of G are the variables in the rule
        visitDepthFirst(clause, [&](const AstVariable& var) {
            variableGraph.insert(var.getName());
            ruleVariables.insert(var.getName());
        });

        // Add in the edges
        // Since we are only looking at reachability in the final graph, it is
        // enough to just add in an (undirected) edge from the first variable
        // in the literal to each of the other variables.
        std::vector<AstLiteral*> literalsToConsider = clause.getBodyLiterals();
        literalsToConsider.push_back(clause.getHead());

        for (AstLiteral* clauseLiteral : literalsToConsider) {
            std::set<std::string> literalVariables;

            // Store all variables in the literal
            visitDepthFirst(
                    *clauseLiteral, [&](const AstVariable& var) { literalVariables.insert(var.getName()); });

            // No new edges if only one variable is present
            if (literalVariables.size() > 1) {
                std::string firstVariable = *literalVariables.begin();
                literalVariables.erase(literalVariables.begin());

                // Create the undirected edge
                for (const std::string& var : literalVariables) {
                    variableGraph.insert(firstVariable, var);
                    variableGraph.insert(var, firstVariable);
                }
            }
        }

        // Find the connected components of G
        std::set<std::string> seenNodes;

        // Find the connected component associated with the head
        std::set<std::string> headComponent;
        visitDepthFirst(
                *clause.getHead(), [&](const AstVariable& var) { headComponent.insert(var.getName()); });

        if (!headComponent.empty()) {
            variableGraph.visitDepthFirst(*headComponent.begin(), [&](const std::string& var) {
                headComponent.insert(var);
                seenNodes.insert(var);
            });
        }

        // Compute all other connected components in the graph G
        std::set<std::set<std::string>> connectedComponents;

        for (std::string var : ruleVariables) {
            if (seenNodes.find(var) != seenNodes.end()) {
                // Node has already been added to a connected component
                continue;
            }

            // Construct the connected component
            std::set<std::string> component;
            variableGraph.visitDepthFirst(var, [&](const std::string& child) {
                component.insert(child);
                seenNodes.insert(child);
            });
            connectedComponents.insert(component);
        }

        if (connectedComponents.empty()) {
            // No separate connected components, so no point partitioning
            return;
        }

        // Need to extract some disconnected lits!
        changed = true;
        std::vector<AstAtom*> replacementAtoms;

        // Construct the new rules
        for (const std::set<std::string>& component : connectedComponents) {
            // Come up with a unique new name for the relation
            static int disconnectedCount = 0;
            std::stringstream nextName;
            nextName << "+disconnected" << disconnectedCount;
            AstRelationIdentifier newRelationName = nextName.str();
            disconnectedCount++;

            // Create the extracted relation and clause for the component
            // newrelX() <- disconnectedLiterals(x).
            auto newRelation = std::make_unique<AstRelation>();
            newRelation->setName(newRelationName);
            program.appendRelation(std::move(newRelation));

            auto* disconnectedClause = new AstClause();
            disconnectedClause->setSrcLoc(clause.getSrcLoc());
            disconnectedClause->setHead(std::make_unique<AstAtom>(newRelationName));

            // Find the body literals for this connected component
            std::vector<AstLiteral*> associatedLiterals;
            for (AstLiteral* bodyLiteral : clause.getBodyLiterals()) {
                bool associated = false;
                visitDepthFirst(*bodyLiteral, [&](const AstVariable& var) {
                    if (component.find(var.getName()) != component.end()) {
                        associated = true;
                    }
                });
                if (associated) {
                    disconnectedClause->addToBody(std::unique_ptr<AstLiteral>(bodyLiteral->clone()));
                }
            }

            // Create the atom to replace all these literals
            replacementAtoms.push_back(new AstAtom(newRelationName));

            // Add the clause to the program
            clausesToAdd.push_back(disconnectedClause);
        }

        // Create the replacement clause
        // a(x) <- b(x), c(y), d(z). --> a(x) <- newrel0(), newrel1(), b(x).
        auto* replacementClause = new AstClause();
        replacementClause->setSrcLoc(clause.getSrcLoc());
        replacementClause->setHead(std::unique_ptr<AstAtom>(clause.getHead()->clone()));

        // Add the new propositions to the clause first
        for (AstAtom* newAtom : replacementAtoms) {
            replacementClause->addToBody(std::unique_ptr<AstLiteral>(newAtom));
        }

        // Add the remaining body literals to the clause
        for (AstLiteral* bodyLiteral : clause.getBodyLiterals()) {
            bool associated = false;
            bool hasVariables = false;
            visitDepthFirst(*bodyLiteral, [&](const AstVariable& var) {
                hasVariables = true;
                if (headComponent.find(var.getName()) != headComponent.end()) {
                    associated = true;
                }
            });
            if (associated || !hasVariables) {
                replacementClause->addToBody(std::unique_ptr<AstLiteral>(bodyLiteral->clone()));
            }
        }

        // Replace the old clause with the new one
        clausesToRemove.push_back(&clause);
        clausesToAdd.push_back(replacementClause);
    });

    // Adjust the program
    for (AstClause* newClause : clausesToAdd) {
        program.appendClause(std::unique_ptr<AstClause>(newClause));
    }

    for (const AstClause* oldClause : clausesToRemove) {
        program.removeClause(oldClause);
    }

    return changed;
}

bool ReduceExistentialsTransformer::transform(AstTranslationUnit& translationUnit) {
    AstProgram& program = *translationUnit.getProgram();

    // Checks whether a given clause is recursive
    auto isRecursiveClause = [&](const AstClause& clause) {
        AstRelationIdentifier relationName = clause.getHead()->getName();
        bool recursive = false;
        visitDepthFirst(clause.getBodyLiterals(), [&](const AstAtom& atom) {
            if (atom.getName() == relationName) {
                recursive = true;
            }
        });
        return recursive;
    };

    // Checks whether an atom is of the form a(_,_,...,_)
    auto isExistentialAtom = [&](const AstAtom& atom) {
        for (AstArgument* arg : atom.getArguments()) {
            if (!dynamic_cast<AstUnnamedVariable*>(arg)) {
                return false;
            }
        }
        return true;
    };

    // Construct a dependency graph G where:
    // - Each relation is a node
    // - An edge (a,b) exists iff a uses b "non-existentially" in one of its *recursive* clauses
    // This way, a relation can be transformed into an existential form
    // if and only if all its predecessors can also be transformed.
    Graph<AstRelationIdentifier> relationGraph = Graph<AstRelationIdentifier>();

    // Add in the nodes
    for (AstRelation* relation : program.getRelations()) {
        relationGraph.insert(relation->getName());
    }

    // Keep track of all relations that cannot be transformed
    std::set<AstRelationIdentifier> minimalIrreducibleRelations;

    auto* ioType = translationUnit.getAnalysis<IOType>();

    for (AstRelation* relation : program.getRelations()) {
        // No I/O relations can be transformed
        if (ioType->isIO(relation)) {
            minimalIrreducibleRelations.insert(relation->getName());
        }
        for (AstClause* clause : relation->getClauses()) {
            bool recursive = isRecursiveClause(*clause);
            visitDepthFirst(*clause, [&](const AstAtom& atom) {
                if (atom.getName() == clause->getHead()->getName()) {
                    return;
                }

                if (!isExistentialAtom(atom)) {
                    if (recursive) {
                        // Clause is recursive, so add an edge to the dependency graph
                        relationGraph.insert(clause->getHead()->getName(), atom.getName());
                    } else {
                        // Non-existential apperance in a non-recursive clause, so
                        // it's out of the picture
                        minimalIrreducibleRelations.insert(atom.getName());
                    }
                }
            });
        }
    }

    // TODO (see issue #564): Don't transform relations appearing in aggregators
    //                        due to aggregator issues with unnamed variables.
    visitDepthFirst(program, [&](const AstAggregator& aggr) {
        visitDepthFirst(
                aggr, [&](const AstAtom& atom) { minimalIrreducibleRelations.insert(atom.getName()); });
    });

    // Run a DFS from each 'bad' source
    // A node is reachable in a DFS from an irreducible node if and only if it is
    // also an irreducible node
    std::set<AstRelationIdentifier> irreducibleRelations;
    for (AstRelationIdentifier relationName : minimalIrreducibleRelations) {
        relationGraph.visitDepthFirst(relationName,
                [&](const AstRelationIdentifier& subRel) { irreducibleRelations.insert(subRel); });
    }

    // All other relations are necessarily existential
    std::set<AstRelationIdentifier> existentialRelations;
    for (AstRelation* relation : program.getRelations()) {
        if (!relation->getClauses().empty() && relation->getArity() != 0 &&
                irreducibleRelations.find(relation->getName()) == irreducibleRelations.end()) {
            existentialRelations.insert(relation->getName());
        }
    }

    // Reduce the existential relations
    for (AstRelationIdentifier relationName : existentialRelations) {
        AstRelation* originalRelation = program.getRelation(relationName);

        std::stringstream newRelationName;
        newRelationName << "+?exists_" << relationName;

        auto newRelation = std::make_unique<AstRelation>();
        newRelation->setName(newRelationName.str());
        newRelation->setSrcLoc(originalRelation->getSrcLoc());

        // EqRel relations require two arguments, so remove it from the qualifier
        newRelation->setQualifier(originalRelation->getQualifier() & ~(EQREL_RELATION));

        // Keep all non-recursive clauses
        for (AstClause* clause : originalRelation->getClauses()) {
            if (!isRecursiveClause(*clause)) {
                auto newClause = std::make_unique<AstClause>();

                newClause->setSrcLoc(clause->getSrcLoc());
                if (const AstExecutionPlan* plan = clause->getExecutionPlan()) {
                    newClause->setExecutionPlan(std::unique_ptr<AstExecutionPlan>(plan->clone()));
                }
                newClause->setGenerated(clause->isGenerated());
                newClause->setFixedExecutionPlan(clause->hasFixedExecutionPlan());
                newClause->setHead(std::make_unique<AstAtom>(newRelationName.str()));
                for (AstLiteral* lit : clause->getBodyLiterals()) {
                    newClause->addToBody(std::unique_ptr<AstLiteral>(lit->clone()));
                }

                newRelation->addClause(std::move(newClause));
            }
        }

        program.appendRelation(std::move(newRelation));
    }

    // Mapper that renames the occurrences of marked relations with their existential
    // counterparts
    struct renameExistentials : public AstNodeMapper {
        const std::set<AstRelationIdentifier>& relations;

        renameExistentials(std::set<AstRelationIdentifier>& relations) : relations(relations) {}

        std::unique_ptr<AstNode> operator()(std::unique_ptr<AstNode> node) const override {
            if (auto* clause = dynamic_cast<AstClause*>(node.get())) {
                if (relations.find(clause->getHead()->getName()) != relations.end()) {
                    // Clause is going to be removed, so don't rename it
                    return node;
                }
            } else if (auto* atom = dynamic_cast<AstAtom*>(node.get())) {
                if (relations.find(atom->getName()) != relations.end()) {
                    // Relation is now existential, so rename it
                    std::stringstream newName;
                    newName << "+?exists_" << atom->getName();
                    return std::make_unique<AstAtom>(newName.str());
                }
            }
            node->apply(*this);
            return node;
        }
    };

    renameExistentials update(existentialRelations);
    program.apply(update);

    bool changed = !existentialRelations.empty();
    return changed;
}

bool ReplaceSingletonVariablesTransformer::transform(AstTranslationUnit& translationUnit) {
    bool changed = false;

    AstProgram& program = *translationUnit.getProgram();

    // Node-mapper to replace a set of singletons with unnamed variables
    struct replaceSingletons : public AstNodeMapper {
        std::set<std::string>& singletons;

        replaceSingletons(std::set<std::string>& singletons) : singletons(singletons) {}

        std::unique_ptr<AstNode> operator()(std::unique_ptr<AstNode> node) const override {
            if (auto* var = dynamic_cast<AstVariable*>(node.get())) {
                if (singletons.find(var->getName()) != singletons.end()) {
                    return std::make_unique<AstUnnamedVariable>();
                }
            }
            node->apply(*this);
            return node;
        }
    };

    for (AstRelation* rel : program.getRelations()) {
        for (AstClause* clause : rel->getClauses()) {
            std::set<std::string> nonsingletons;
            std::set<std::string> vars;

            visitDepthFirst(*clause, [&](const AstVariable& var) {
                const std::string& name = var.getName();
                if (vars.find(name) != vars.end()) {
                    // Variable seen before, so not a singleton variable
                    nonsingletons.insert(name);
                } else {
                    vars.insert(name);
                }
            });

            std::set<std::string> ignoredVars;

            // Don't unname singleton variables occurring in records.
            // TODO (azreika): remove this check once issue #420 is fixed
            std::set<std::string> recordVars;
            visitDepthFirst(*clause, [&](const AstRecordInit& rec) {
                visitDepthFirst(rec, [&](const AstVariable& var) { ignoredVars.insert(var.getName()); });
            });

            // Don't unname singleton variables occuring in constraints.
            std::set<std::string> constraintVars;
            visitDepthFirst(*clause, [&](const AstConstraint& cons) {
                visitDepthFirst(cons, [&](const AstVariable& var) { ignoredVars.insert(var.getName()); });
            });

            std::set<std::string> singletons;
            for (auto& var : vars) {
                if ((nonsingletons.find(var) == nonsingletons.end()) &&
                        (ignoredVars.find(var) == ignoredVars.end())) {
                    changed = true;
                    singletons.insert(var);
                }
            }

            // Replace the singletons found with underscores
            replaceSingletons update(singletons);
            clause->apply(update);
        }
    }

    return changed;
}

bool RemoveRedundantSumsTransformer::transform(AstTranslationUnit& translationUnit) {
    struct ReplaceSumWithCount : public AstNodeMapper {
        ReplaceSumWithCount() {}

        std::unique_ptr<AstNode> operator()(std::unique_ptr<AstNode> node) const override {
            // Apply to all aggregates of the form
            // sum k : { .. } where k is a constant
            if (auto* agg = dynamic_cast<AstAggregator*>(node.get())) {
                if (agg->getOperator() == AstAggregator::Op::sum) {
                    if (const auto* constant =
                                    dynamic_cast<const AstNumberConstant*>(agg->getTargetExpression())) {
                        changed = true;
                        // Then construct the new thing to replace it with
                        auto count = std::make_unique<AstAggregator>(AstAggregator::Op::count);
                        // Duplicate the body of the aggregate
                        for (const auto& lit : agg->getBodyLiterals()) {
                            count->addBodyLiteral(std::unique_ptr<AstLiteral>(lit->clone()));
                        }
                        auto number = std::unique_ptr<AstNumberConstant>(constant->clone());
                        // Now it's constant * count : { ... }
                        auto result = std::make_unique<AstIntrinsicFunctor>(
                                FunctorOp::MUL, std::move(number), std::move(count));

                        return std::move(result);
                    }
                }
            }
            node->apply(*this);
            return node;
        }

        // variables
        mutable bool changed = false;
    };

    ReplaceSumWithCount update;
    translationUnit.getProgram()->apply(update);
    return update.changed;
}

bool NormaliseConstraintsTransformer::transform(AstTranslationUnit& translationUnit) {
    bool changed = false;

    // set a prefix for variables bound by magic-set for identification later
    // prepended by + to avoid conflict with user-defined variables
    static constexpr const char* boundPrefix = "+abdul";

    AstProgram& program = *translationUnit.getProgram();

    /* Create a node mapper that recursively replaces all constants and underscores
     * with named variables.
     *
     * The mapper keeps track of constraints that should be added to the original
     * clause it is being applied on in a given constraint set.
     */
    struct constraintNormaliser : public AstNodeMapper {
        std::set<AstBinaryConstraint*>& constraints;
        mutable int changeCount;

        constraintNormaliser(std::set<AstBinaryConstraint*>& constraints, int changeCount)
                : constraints(constraints), changeCount(changeCount) {}

        bool hasChanged() const {
            return changeCount > 0;
        }

        int getChangeCount() const {
            return changeCount;
        }

        std::unique_ptr<AstNode> operator()(std::unique_ptr<AstNode> node) const override {
            if (auto* stringConstant = dynamic_cast<AstStringConstant*>(node.get())) {
                // string constant found
                changeCount++;

                // create new variable name (with appropriate suffix)
                std::string constantValue = stringConstant->getConstant();
                std::stringstream newVariableName;
                newVariableName << boundPrefix << changeCount << "_" << constantValue << "_s";

                // create new constraint (+abdulX = constant)
                auto newVariable = std::make_unique<AstVariable>(newVariableName.str());
                constraints.insert(new AstBinaryConstraint(BinaryConstraintOp::EQ,
                        std::unique_ptr<AstArgument>(newVariable->clone()),
                        std::unique_ptr<AstArgument>(stringConstant->clone())));

                // update constant to be the variable created
                return std::move(newVariable);
            } else if (auto* numberConstant = dynamic_cast<AstNumberConstant*>(node.get())) {
                // number constant found
                changeCount++;

                // create new variable name (with appropriate suffix)
                AstDomain constantValue = numberConstant->getIndex();
                std::stringstream newVariableName;
                newVariableName << boundPrefix << changeCount << "_" << constantValue << "_n";

                // create new constraint (+abdulX = constant)
                auto newVariable = std::make_unique<AstVariable>(newVariableName.str());
                constraints.insert(new AstBinaryConstraint(BinaryConstraintOp::EQ,
                        std::unique_ptr<AstArgument>(newVariable->clone()),
                        std::unique_ptr<AstArgument>(numberConstant->clone())));

                // update constant to be the variable created
                return std::move(newVariable);
            } else if (dynamic_cast<AstUnnamedVariable*>(node.get())) {
                // underscore found
                changeCount++;

                // create new variable name
                std::stringstream newVariableName;
                newVariableName << "+underscore" << changeCount;

                return std::make_unique<AstVariable>(newVariableName.str());
            }

            node->apply(*this);
            return node;
        }
    };

    int changeCount = 0;  // number of constants and underscores seen so far

    // apply the change to all clauses in the program
    for (AstRelation* rel : program.getRelations()) {
        for (AstClause* clause : rel->getClauses()) {
            if (clause->isFact()) {
                continue;  // don't normalise facts
            }

            std::set<AstBinaryConstraint*> constraints;
            constraintNormaliser update(constraints, changeCount);
            clause->apply(update);

            changeCount = update.getChangeCount();
            changed = changed || update.hasChanged();

            for (AstBinaryConstraint* constraint : constraints) {
                clause->addToBody(std::unique_ptr<AstBinaryConstraint>(constraint));
            }
        }
    }

    return changed;
}

bool RemoveTypecastsTransformer::transform(AstTranslationUnit& translationUnit) {
    struct TypecastRemover : public AstNodeMapper {
        mutable bool changed{false};

        std::unique_ptr<AstNode> operator()(std::unique_ptr<AstNode> node) const override {
            // remove sub-typecasts first
            node->apply(*this);

            // if current node is a typecast, replace with the value directly
            if (auto* cast = dynamic_cast<AstTypeCast*>(node.get())) {
                changed = true;
                return std::unique_ptr<AstArgument>(cast->getValue()->clone());
            }

            // otherwise, return the original node
            return node;
        }
    };

    TypecastRemover update;
    translationUnit.getProgram()->apply(update);

    return update.changed;
}

}  // end of namespace souffle
