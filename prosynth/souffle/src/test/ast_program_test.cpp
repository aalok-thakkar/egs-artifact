/*
 * Souffle - A Datalog Compiler
 * Copyright (c) 2013, 2015, Oracle and/or its affiliates. All rights reserved
 * Licensed under the Universal Permissive License v 1.0 as shown at:
 * - https://opensource.org/licenses/UPL
 * - <souffle root>/licenses/SOUFFLE-UPL.txt
 */

/************************************************************************
 *
 * @file ast_program_test.cpp
 *
 * Tests souffle's AST program.
 *
 ***********************************************************************/

#include "AstProgram.h"
#include "AstTranslationUnit.h"
#include "ParserDriver.h"
#include "SymbolTable.h"
#include "test.h"

namespace souffle {

namespace test {

TEST(AstProgram, Parse) {
    SymbolTable sym;
    ErrorReport e;
    DebugReport d;
    // check the empty program
    std::unique_ptr<AstTranslationUnit> empty = ParserDriver::parseTranslationUnit("", sym, e, d);

    EXPECT_TRUE(empty->getProgram()->getTypes().empty());
    EXPECT_TRUE(empty->getProgram()->getRelations().empty());

    // check something simple
    std::unique_ptr<AstTranslationUnit> tu = ParserDriver::parseTranslationUnit(
            R"(
                   .type Node
                   .decl e ( a : Node , b : Node )
                   .decl r ( from : Node , to : Node )

                   r(X,Y) :- e(X,Y).
                   r(X,Z) :- r(X,Y), r(Y,Z).
            )",
            sym, e, d);

    auto* prog = tu->getProgram();
    std::cout << *prog << "\n";

    EXPECT_EQ(1, prog->getTypes().size());
    EXPECT_EQ(2, prog->getRelations().size());

    EXPECT_TRUE(prog->getRelation("e"));
    EXPECT_TRUE(prog->getRelation("r"));
    EXPECT_FALSE(prog->getRelation("n"));
}

#define TESTASTCLONEANDEQUAL(SUBTYPE, DL)                                                           \
    TEST(Ast, CloneAndEqual##SUBTYPE) {                                                             \
        SymbolTable sym;                                                                            \
        ErrorReport e;                                                                              \
        DebugReport d;                                                                              \
        std::unique_ptr<AstTranslationUnit> tu = ParserDriver::parseTranslationUnit(DL, sym, e, d); \
        AstProgram& program = *tu->getProgram();                                                    \
        EXPECT_EQ(program, program);                                                                \
        std::unique_ptr<AstProgram> clone(program.clone());                                         \
        EXPECT_NE(clone.get(), &program);                                                           \
        EXPECT_EQ(*clone, program);                                                                 \
    }

TESTASTCLONEANDEQUAL(Program,
        R"(
                 .decl r(a:number,b:number,c:number,d:number)
                 .decl s(x:symbol)
                 .decl a(x:number)
                 s("xxx").
                 r(X,Y,Z,W) :- a(X), 10 = Y, Y = Z, 8 + W = 12 + 14.
                 r(z + 2, x, y, a) :- s(b), b = to_string(a), z = x, a = y, x = 2, a = 2 + x.
            )");

TESTASTCLONEANDEQUAL(Record,
        R"(
                 .type N
                 .type R = [ a : N, B : N ]


                 .decl r ( r : R )
                 .decl s ( r : N )

                 s(x) :- r([x,y]).

            )");

TESTASTCLONEANDEQUAL(SimpleTypes,
        R"(
                 .type A
                 .type B
                 .type U = A | B

                 .decl a ( x : A )
                 .decl b ( x : B )
                 .decl u ( x : U )

                 a(X) :- u(X).
                 b(X) :- u(X).
                 u(X) :- u(X).

                 a(X) :- b(X).
                 a(X) :- b(Y).

            )");

TESTASTCLONEANDEQUAL(ComplexTypes,
        R"(
                 .symbol_type A
                 .number_type B
                 .type U = B

                 .decl a ( x : A )
                 .decl b ( x : B )
                 .decl u ( x : U )

                 a(X) :- X < 10.
                 b(X) :- X < 10.
                 u(X) :- X < 10.

            )");

TESTASTCLONEANDEQUAL(ChainedTypes,
        R"(
                .type D
                .type C = D
                .type B = C
                .type A = B

                .decl R1(x:A,y:B)
                .decl R2(x:C,y:D)
                .decl R4(x:A) output

                R4(x) :- R2(x,x),R1(x,x).
            )");

TESTASTCLONEANDEQUAL(NestedAggregates,
        R"(
                .type D
                .decl r(x:D)

                r(x) :- r(y), x=cat(cat(x,x),x).
            )");

TESTASTCLONEANDEQUAL(RelationCopies,
        R"(
                .type D = number
                .decl a(a:D,b:D)
                .decl b(a:D,b:D)
                .decl c(a:D,b:D)
                .decl d(a:D,b:D)

                a(1,2).
                b(x,y) :- a(x,y).
                c(x,y) :- b(x,y).

                d(x,y) :- b(x,y), c(y,x).

            )");

}  // end namespace test
}  // end namespace souffle
