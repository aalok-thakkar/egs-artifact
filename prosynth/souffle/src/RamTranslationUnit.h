/*
 * Souffle - A Datalog Compiler
 * Copyright (c) 2015, Oracle and/or its affiliates. All rights reserved
 * Licensed under the Universal Permissive License v 1.0 as shown at:
 * - https://opensource.org/licenses/UPL
 * - <souffle root>/licenses/SOUFFLE-UPL.txt
 */

/************************************************************************
 *
 * @file RamTranslationUnit.h
 *
 * Define a class that represents a Datalog translation unit, consisting
 * of a datalog program, error reports and cached analysis results.
 *
 ***********************************************************************/

#pragma once

#include "DebugReport.h"
#include "ErrorReport.h"
#include "RamAnalysis.h"
#include "RamProgram.h"
#include "SymbolTable.h"

#include <map>
#include <memory>
#include <mutex>
#include <string>

namespace souffle {

/**
 * @class RamTranslationUnit
 * @brief Translating a RAM program
 *
 * Comprises the program, symbol table, error report and debug report
 */
class RamTranslationUnit {
public:
    RamTranslationUnit(std::unique_ptr<RamProgram> program, SymbolTable& sym, ErrorReport& e, DebugReport& d)
            : program(std::move(program)), symbolTable(sym), errorReport(e), debugReport(d) {}

    virtual ~RamTranslationUnit() = default;

    /** @brief templated method to compute/retrieve an analysis for a translation unit */
    template <class Analysis>
    Analysis* getAnalysis() const {
        std::string name = Analysis::name;
        auto it = analyses.find(name);
        if (it == analyses.end()) {
            // analysis does not exist yet, create instance and run it.
            auto analysis = std::make_unique<Analysis>(Analysis::name);
            analysis->run(*this);
            // Check it hasn't been created by someone else, and insert if not
            std::lock_guard<std::mutex> guard(analysisLock);
            it = analyses.find(name);
            if (it == analyses.end()) {
                analyses[name] = std::move(analysis);
            }
        }
        return dynamic_cast<Analysis*>(analyses[name].get());
    }

    /** @brief get the set of alive analyses of the translation unit */
    std::set<const RamAnalysis*> getAliveAnalyses() const {
        std::set<const RamAnalysis*> result;
        for (auto const& a : analyses) {
            result.insert(a.second.get());
        }
        return result;
    }

    /** @brief throw away all alive analyses of the translation unit */
    void invalidateAnalyses() {
        analyses.clear();
    }

    /** @brief get the const RAM Program of the translation unit  */
    const RamProgram* getProgram() const {
        return program.get();
    }

    /** @brief get the RAM Program of the translation unit  */
    RamProgram* getProgram() {
        return program.get();
    }

    /** @brief get symbol table  */
    souffle::SymbolTable& getSymbolTable() const {
        return symbolTable;
    }

    /** @brief get error report */
    ErrorReport& getErrorReport() {
        return errorReport;
    }

    /** @brief get error report */
    const ErrorReport& getErrorReport() const {
        return errorReport;
    }

    /** @brief get debug report */
    DebugReport& getDebugReport() {
        return debugReport;
    }

    /** @brief get const debug report */
    const DebugReport& getDebugReport() const {
        return debugReport;
    }

protected:
    /* cached analyses */
    mutable std::map<std::string, std::unique_ptr<RamAnalysis>> analyses;

    /* Program RAM */
    std::unique_ptr<RamProgram> program;

    /* The table of symbols encountered in the input program */
    souffle::SymbolTable& symbolTable;

    /* Error report for raising errors and warnings */
    ErrorReport& errorReport;

    /* Debug report for logging information */
    DebugReport& debugReport;

    /* TODO (b-scholz): this should disappear with the new interpreter */
    mutable std::mutex analysisLock;
};

}  // end of namespace souffle
