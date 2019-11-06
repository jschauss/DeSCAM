//
// Created by M.I.Alkoudsi on 22.08.19.
//

#ifndef SCAM_FINDVARIABLESVALUES_H
#define SCAM_FINDVARIABLESVALUES_H

#include "Behavior/CfgNode.h"
#include <set>
#include <utility>
#include <Stmts/StmtAbstractVisitor.h>
#include <Stmts/Stmts_all.h>

namespace SCAM {
    /***
   * @brief: checks assignments to variables that are not read in the CFG and stores them
   *
   * Important!: compound expressions values are not stored, only the values of their sub variables!
   *
   */

    class FindVariablesValues {

    public:
        FindVariablesValues() = delete;

        FindVariablesValues(const std::map<int, CfgNode *> &CFG, std::set<std::string> readVariablesSet);

        ~FindVariablesValues() = default;

        const std::map<std::string, std::set<SCAM::Expr *>> &getVariableValuesMap() const;

    private:
        std::map<int, CfgNode *> CFG;
        std::map<std::string, std::set<SCAM::Expr *>> variablesValuesMap;
        std::set<std::string> readVariablesSet;

        void addValToVariableValuesMap(SCAM::Variable *variable, SCAM::Expr *rhs);
    };
}

#endif //SCAM_FINDVARIABLESVALUES_H