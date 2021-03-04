/*
 * Souffle - A Datalog Compiler
 * Copyright (c) 2018, The Souffle Developers. All rights reserved.
 * Licensed under the Universal Permissive License v 1.0 as shown at:
 * - https://opensource.org/licenses/UPL
 * - <souffle root>/licenses/SOUFFLE-UPL.txt
 */

/************************************************************************
 *
 * @file Synthesiser.h
 *
 * Declares synthesiser classes to synthesise C++ code from a RAM program.
 *
 ***********************************************************************/

#pragma once

#include "RamStatement.h"
#include "RamTypes.h"
#include <map>
#include <memory>
#include <ostream>
#include <set>
#include <string>

namespace souffle {

class RamOperation;
class RamTranslationUnit;
class SynthesiserRelation;
class RamRelation;

/**
 * A RAM synthesiser: synthesises a C++ program from a RAM program.
 */
class Synthesiser {
private:
    /** RAM translation unit */
    RamTranslationUnit& translationUnit;

    /** RAM identifier to C++ identifier map */
    std::map<const std::string, const std::string> identifiers;

    /** Frequency profiling of searches */
    std::map<std::string, unsigned> idxMap;

    /** Frequency profiling of non-existence checks */
    std::map<std::string, size_t> neIdxMap;

    /** Cache for generated types for relations */
    std::set<std::string> typeCache;

protected:
    /** Convert RAM identifier */
    const std::string convertRamIdent(const std::string& name);

    /** Check whether indexes are disabled */
    bool areIndexesDisabled();

    /** Get relation name */
    const std::string getRelationName(const RamRelation& rel);

    /** Get relation name */
    const std::string getRelationName(const std::string& relName);

    /** Get context name */
    const std::string getOpContextName(const RamRelation& rel);

    /** Get relation struct definition */
    void generateRelationTypeStruct(std::ostream& out, std::unique_ptr<SynthesiserRelation> relationType);

    /* Convert SearchColums to a template index */
    std::string toIndex(SearchSignature key);

    /** Get referenced relations */
    std::set<const RamRelation*> getReferencedRelations(const RamOperation& op);

    /** Generate code */
    void emitCode(std::ostream& out, const RamStatement& stmt);

    /** Lookup frequency counter */
    unsigned lookupFreqIdx(const std::string& txt);

    /** Lookup read counter */
    size_t lookupReadIdx(const std::string& txt);

public:
    Synthesiser(RamTranslationUnit& tUnit) : translationUnit(tUnit) {}
    virtual ~Synthesiser() = default;

    /** Get translation unit */
    RamTranslationUnit& getTranslationUnit() {
        return translationUnit;
    }

    /** Generate code */
    void generateCode(std::ostream& os, const std::string& id, bool& withSharedLibrary);
};
}  // end of namespace souffle
