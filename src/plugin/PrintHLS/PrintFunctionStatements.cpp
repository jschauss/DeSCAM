//
// Created by johannes on 28.07.19.
//

#include <memory>

#include "PrintFunctionStatements.h"
#include "NodePeekVisitor.h"
#include "PrintOperations.h"

using namespace SCAM;

PrintFunctionStatements::PrintFunctionStatements(Stmt *stmt, Utilities *utils, unsigned int indentSize, unsigned int indentOffset) {
    skip = false;
    side = Side::UNKNOWN;
    this->utilities = utils;
    this->createString(stmt, indentSize, indentOffset);
}

std::string PrintFunctionStatements::toString(Stmt *stmt, unsigned int indentSize, unsigned int indentOffset) {
    PrintFunctionStatements printer(stmt, nullptr, indentSize, indentOffset);
    return printer.getString();
}

std::string PrintFunctionStatements::toString(Stmt *stmt, Utilities *utils, unsigned int indentSize, unsigned int indentOffset) {
    PrintFunctionStatements printer(stmt, utils, indentSize, indentOffset);
    return printer.getString();
}

std::string PrintFunctionStatements::getString() {
    return this->ss.str();
}

void PrintFunctionStatements::visit(Assignment &node) {
    printIndent();
    side = Side::LHS;
    node.getLhs()->accept(*this);
    if (!skip) {
        this->ss << " = ";
        side = Side::RHS;
        node.getRhs()->accept(*this);
        this->ss << ";\n";
    } else {
        this->ss.str("");
    }
}

void PrintFunctionStatements::visit(VariableOperand &node) {
    if (utilities) {
        auto regs = utilities->getRegisters();
        if(side == Side::LHS) {
//            if (regs.find(node.getVariable()) == regs.end()) {
//                skip = true;
//            } else {
                this->ss << "next_";
//            }
        }
    }
    if (!skip) {
        if (node.getVariable()->isSubVar()) {
            this->ss << node.getVariable()->getParent()->getName();
            if (node.getVariable()->getParent()->isArrayType()) {
                this->ss << "[" << node.getVariable()->getName() << "]";
            } else {
                this->ss << "_" << node.getVariable()->getName();
            }
        } else {
            this->ss << node.getVariable()->getName();
        }
    }
}

void PrintFunctionStatements::visit(DataSignalOperand &node) {
    this->ss << node.getDataSignal()->getPort()->getName() << "_sig";
    if (node.getDataSignal()->isSubVar()) {
        if (node.getDataSignal()->getParent()->isArrayType()) {
            this->ss << "[" << node.getDataSignal()->getName() << "]";
        } else {
            this->ss << "." << node.getDataSignal()->getName();
        }
    }
}

void PrintFunctionStatements::visit(SyncSignal &node) {
    this->ss << node.getPort()->getName() << "_sync";
}

void PrintFunctionStatements::visit(UnaryExpr &node) {
    useParenthesesFlag = true;
    this->ss << "(";
    if (node.getOperation() == "not") {
        this->ss << "!(";
        node.getExpr()->accept(*this);
        this->ss << ")";
    }
    else {
        this->ss << node.getOperation() << "(";
        node.getExpr()->accept(*this);
        this->ss << ")";
    }
    this->ss << ")";
}

void PrintFunctionStatements::visit(CompoundExpr &node) {
    for (auto value = node.getValueMap().begin(); value != node.getValueMap().end(); ++value) {
        NodePeekVisitor nodePeekVisitor(value->second);
        if (nodePeekVisitor.nodePeekDataSignalOperand()) {
            this->ss << nodePeekVisitor.nodePeekDataSignalOperand()->getDataSignal()->getParent()->getName();
            value = --node.getValueMap().end();
            break;
        } else {
            value->second->accept(*this);
        }
        if (std::next(value) != node.getValueMap().end()) {
            this->ss << ", ";
        }
    }
}

void PrintFunctionStatements::visit(Cast &node) {
    this->ss << "static_cast<" << node.getDataType()->getName() << ">(";
    node.getSubExpr()->accept(*this);
    this->ss << ")";
}

void PrintFunctionStatements::visit(ITE &node) {
    for (std::size_t i = 0; i < indent; i++) {
        this->ss << " ";
    }
    this->ss << "if (";
    node.getConditionStmt()->accept(*this);
    this->ss << ") {" << std::endl;
    indent += indentSize;
    for (auto stmt: node.getIfList()) {
        for (std::size_t i = 0; i < indent; ++i) {
            this->ss << " ";    //add indent
        }
        std::string statementString = PrintFunctionStatements::toString(stmt, indentSize, indent);
        this->ss << statementString;
        if (statementString.find('\n') == std::string::npos)
            this->ss << ";";
        this->ss << std::endl;
    }
    indent -= indentSize;
    for (std::size_t i = 0; i < indent; ++i) {
        this->ss << " "; //add indent
    }
    this->ss << "}";
    if (!node.getElseList().empty()) {
        this->ss << " else {" << std::endl;
        indent += indentSize;
        for (auto stmt: node.getElseList()) {
            for (std::size_t i = 0; i < indent; ++i) {
                this->ss << " ";    //add indent
            }
            if (NodePeekVisitor::nodePeekITE(stmt) != nullptr)
                indent -= indentSize;
            std::string statementString = PrintFunctionStatements::toString(stmt, indentSize, indent);
            this->ss << statementString;
            if (statementString.find('\n') == std::string::npos)
                this->ss << ";";
            this->ss << std::endl;
        }
        indent -= indentSize;
        for (std::size_t i = 0; i < indent; ++i) {
            this->ss << " ";    //add indent
        }
        this->ss << "}";
    }
}

void PrintFunctionStatements::visit(Return &node) {
    printIndent();
    this->ss << "return(";
    node.getReturnValue()->accept(*this);
    this->ss << ")";
}

void PrintFunctionStatements::visit(ParamOperand &node) {
    if (node.getParameter()->isSubVar()) {
        this->ss << node.getParameter()->getParent()->getName() << "."
            << node.getParameter()->getName();
    }
    else {
        this->ss << node.getOperandName();
    }
}

void PrintFunctionStatements::visit(Logical &node) {
    node.getLhs()->accept(*this);
    if (node.getOperation() == "or") {
        this->ss << " || ";
    } else if(node.getOperation() == "and") {
        this->ss << " && ";
    }
    node.getRhs()->accept(*this);
}

void PrintFunctionStatements::visit(FunctionOperand &node) {
    this->ss << node.getOperandName() << "(";
    for (auto parameter = node.getParamValueMap().begin(); parameter != node.getParamValueMap().end(); ++parameter) {
        parameter->second->accept(*this);
        if (std::next(parameter) != node.getParamValueMap().end()) {
            this->ss << ", ";
        }
    }
    this->ss << ")";
}

void PrintFunctionStatements::visit(Bitwise &node) {
    std::unique_ptr<PrintOperations> printOperations = std::make_unique<PrintOperations>(&node);
    if (printOperations->isSlicingOp()) {
        this->ss << printOperations->getOpAsString(PrintStyle::HLS);
    } else {
        if ((node.getOperation() == "<<") || (node.getOperation() == ">>")) {
            this->ss << "(";
            if (!NodePeekVisitor::nodePeekCast(node.getLhs())) {
                this->ss << "static_cast<ap_uint>(";
            }
            node.getLhs()->accept(*this);
            if (!NodePeekVisitor::nodePeekCast(node.getLhs())) {
                this->ss << ")";
            }
            this->ss << " " + node.getOperation() << " ";
            if (!NodePeekVisitor::nodePeekCast(node.getLhs())) {
                this->ss << "static_cast<ap_uint>(";
            }
            node.getRhs()->accept(*this);
            if (!NodePeekVisitor::nodePeekCast(node.getLhs())) {
                this->ss << ")";
            }
            this->ss << ")";
        } else {
            this->ss << "(";
            node.getLhs()->accept(*this);
            this->ss << " " + node.getOperation() << " ";
            node.getRhs()->accept(*this);
            this->ss << ")";
        }
    }
}

void PrintFunctionStatements::printIndent() {
    for (std::size_t i = 0; i < indent; ++i) {
        this->ss << "\t";
    }
}