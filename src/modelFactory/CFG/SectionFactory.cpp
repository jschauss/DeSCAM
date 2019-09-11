//
// Created by ludwig on 21.01.16.
//

#include <Stmts/Relational.h>
#include <PrintStmt.h>
#include "VariableOperand.h"
#include "IntegerValue.h"
#include "Assignment.h"
#include "BoolValue.h"
#include "SectionOperand.h"
#include "SectionValue.h"
#include "While.h"

#include "SectionFactory.h"
#include "CfgUtilities.h"


//Constructor
SCAM::SectionFactory::SectionFactory(SCAM::Module *module, const std::map<int, CFGNode *> &controlFlowMap, bool expliciteStates) :
        module(module),
        controlFlowMap(controlFlowMap),
        explicteState(expliciteStates){
    //Find startNode,endNode for every block with if-terminator and to startEndMap
    //This is later coverd during creation of the model, right now hard coded
    //this->findStartEndMap();
    this->startEndMap = SCAM::CfgUtilities::getStartEndMap(controlFlowMap);
    this->pathNodeMap = SCAM::CfgUtilities::getPathNodes(this->startEndMap);
    //this->initList();
    this->findSections();
    this->findFlattenModel();

}

void SCAM::SectionFactory::findFlattenModel() {
    //Generate a flattenList for each state-section of the fsm
    if (explicteState) {
        for (auto section: this->sectionMap) {
            //In case of if in block -> flatten the if into an ITE Object
            //Starts with the if-blocks for the statemachine
            if (section.second->hasIf()) {
                FlattenIf flattenRegular(section.second, startEndMap[section.second], startEndMap, this->pathNodeMap);
                this->sectionPathMap.insert(std::make_pair(section.first, flattenRegular.getITE()->getIfList()));
            }
        }
    }
    //Module only has impilcit state init&run
    else {
        //The only statements are defined within the body of the while(true) that is the successor of the while
        auto section = this->sectionMap["run"];
        //std::vector<Stmts*> successors = section->getSuccessorList()[0]->getStmtList();
        //this->sectionPathMap.insert(std::make_pair("run",successors));
        FlattenWhile flattenWhile(section, startEndMap[section], startEndMap, this->pathNodeMap);
        this->sectionPathMap.insert(std::make_pair("run", flattenWhile.getStmtList()));
    }
}

void SCAM::SectionFactory::print() {
    for (auto entry: sectionPathMap) {
        std::cout << "--------------------" << std::endl;
        std::cout << "----Section: " << entry.first << std::endl;
        std::cout << "--------------------" << std::endl;

        for (auto stmt: entry.second) {

            std::cout << PrintStmt::toString(stmt) << std::endl;
        }
    }
}

const std::map<std::string, std::vector<SCAM::Stmt *>> & SCAM::SectionFactory::getSectionPathMap() {
    return sectionPathMap;
}

void SCAM::SectionFactory::findSections() {
    //Stats defined in module description ?
    if (explicteState) {

        //Search for state defining conditions in block
        auto susCFGMap = this->controlFlowMap;
        //Iterate over each block of the suspension CFG
        for (auto entry: susCFGMap) {
            if (entry.second->hasTerminator()) {
                Stmt *term = entry.second->getTerminator();
                if (SCAM::If *ifObjekt = dynamic_cast<SCAM::If *>(term)) {
                    if (SCAM::Relational *compare = dynamic_cast<SCAM::Relational *>(ifObjekt->getConditionStmt())) {
                        Expr *lhs = compare->getLhs();
                        Expr *rhs = compare->getRhs();
                        SCAM::SectionOperand *stateVar = dynamic_cast<SCAM::SectionOperand *>(lhs);
                        SCAM::SectionValue *stateValue = dynamic_cast<SCAM::SectionValue *>(rhs);

                        if (stateVar != nullptr && stateValue != nullptr) {
                            if (stateVar->getName() == "section") {
                                if (sectionMap.find(stateValue->getValue()) != sectionMap.end()) {
                                    throw std::runtime_error("Multiple definition of section");
                                }

                                this->sectionMap.insert(std::make_pair(stateValue->getValue(), entry.second));
                            }

                        }
                    }
                }
            }
        }
    }
        //No stats defined evertything contained within in the while(true) loop is added to state run
    else {
        auto susCFGMap = this->controlFlowMap;
        for (auto entry: susCFGMap) {
            if (entry.second->hasTerminator()) {
                Stmt *term = entry.second->getTerminator();

                if (SCAM::While *whileObjekt = dynamic_cast<SCAM::While *>(term)) {
                    //If while(true): section run starts with successor
                    if (BoolValue *val = dynamic_cast<BoolValue *>(whileObjekt->getConditionStmt())) {
                        if (sectionMap.find("run") != sectionMap.end())
                            throw std::runtime_error("Section contains more than 1 while(true) loop");
                        this->sectionMap.insert(std::make_pair("run", entry.second));
                    } else throw std::runtime_error("Only 1 while(true) loop is allowed!");
                }
            }
        }
    }

}

