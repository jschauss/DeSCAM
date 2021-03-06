//
// Created by tobias on 25.11.15.
//

#ifndef SCAM_CREATESUSPENSIONAUTOMATA_H
#define SCAM_CREATESUSPENSIONAUTOMATA_H

#include <clang/AST/Stmt.h>
#include <clang/Analysis/CFG.h>
#include <clang/Basic/SourceManager.h>
#include <clang/Frontend/CompilerInstance.h>
#include <clang/AST/DeclCXX.h>
#include <Model.h>

#include "CfgBlock.h"
#include "PrintStmt.h"

#include "Module.h"


namespace SCAM {
    /***
     * @brief: Constructs a general purpose CFG from a clang-cfg
     *
     * The extracted CFG already contains SCAM stmts instead of clang::stmts
     */
    class CFGFactory {
    public:
        CFGFactory(clang::CXXMethodDecl *, clang::CompilerInstance &ci, Module *module, bool sourceModule = false);
        CFGFactory(const clang::FunctionDecl  * , clang::CompilerInstance &ci, Module *module, bool sourceModule = false);
        ~CFGFactory() = default;

        const std::map<int, CfgBlock *> &getControlFlowMap() const;

        std::string print();

    private:
        //Methods
        void translateToScamCFG(); //! Top method: initiates generation of the suspensionCFG
        bool exprContainedInIf(clang::CFGBlock *inner, clang::CFGBlock *outer);

        std::vector<clang::Stmt *> getCleanStmtList(clang::CFGBlock *block); //! Returns a list without nested stmts
        CfgBlock *createCFGNode(clang::CFGBlock *block, SCAM::CfgBlock *parent); //! Iterates over each statement of a block
        void traverseBlocks(clang::CFGBlock *block, CfgBlock *parent); //! Traveres each block of the CFG
        void cleanEmptyBlocks(); //! Removes blocks from the susCFG that don't contain stmts or conditions

        SCAM::Stmt *getScamStmt(clang::Stmt *clangStmt); //Return the respective SCAM::Stmts for a clang clang::Stmts
        //Members
        clang::CXXMethodDecl *methodDecl;
        clang::CFG *clangCFG;
        clang::CompilerInstance &ci;
        SCAM::Module *module;
        bool sourceModule;

        //Map
        std::map<int, int> entryMap; //! Contains an entry with <CFGBlockID,SusCFGBlockID>; If a block is split up it point to the first new block
        std::map<int, CfgBlock *> controlFlowMap; //! Contains an entry for every blockId in the CFG

    };
}


#endif //SCAM_CREATESUSPENSIONAUTOMATA_H
