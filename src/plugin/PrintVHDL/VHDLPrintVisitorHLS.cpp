//
// Created by johannes on 10.09.19.
//

#include <memory>

#include "NodePeekVisitor.h"
#include "PrintHLS/BitSlicingHLS.h"
#include "VHDLPrintVisitorHLS.h"

using namespace SCAM;

VHDLPrintVisitorHLS::VHDLPrintVisitorHLS(Stmt *stmt, unsigned int indentSize, unsigned int indentOffset) {
    this->createString(stmt, indentSize, indentOffset);
}

std::string VHDLPrintVisitorHLS::toString(Stmt *stmt, unsigned int indentSize, unsigned int indentOffset) {
    VHDLPrintVisitorHLS printer(stmt, indentSize, indentOffset);
    return printer.getString();
}

std::string VHDLPrintVisitorHLS::getString() {
    return this->ss.str();
}

void VHDLPrintVisitorHLS::visit(SyncSignal &node) {
    this->ss << "(" << node.getPort()->getName() << "_sync = '1')";
}

void VHDLPrintVisitorHLS::visit(Bitwise &node) {
    bool tempUseParentheses = useParenthesesFlag;
    useParenthesesFlag = true;

    std::unique_ptr<BitSlicingHLS> printOperations = std::make_unique<BitSlicingHLS>(&node);
    if (printOperations->isSlicingOp()) {
        this->ss << printOperations->getOpAsString();
    } else {
        if ((node.getOperation() == Utilities::subTypeBitwiseToString(SubTypeBitwise::LEFT_SHIFT)) ||
            (node.getOperation() == Utilities::subTypeBitwiseToString(SubTypeBitwise::RIGHT_SHIFT))) {
            if (node.getOperation() == Utilities::subTypeBitwiseToString(SubTypeBitwise::LEFT_SHIFT))
                this->ss << "shift_left(";
            else if (node.getOperation() == Utilities::subTypeBitwiseToString(SubTypeBitwise::RIGHT_SHIFT))
                this->ss << "shift_right(";
            useParenthesesFlag = false;
            node.getLhs()->accept(*this);
            NodePeekVisitor nodePeek(node.getRhs());
            this->ss << ", ";
            if (nodePeek.nodePeekIntegerValue()) {
                this->ss << nodePeek.nodePeekIntegerValue()->getValue();
            } else if (nodePeek.nodePeekUnsignedValue()) {
                this->ss << nodePeek.nodePeekUnsignedValue()->getValue();
            } else {
                this->ss << "to_integer(";
                useParenthesesFlag = false;
                bool tempUseHexFlag = useHexFlag;
                useHexFlag = false;
                node.getRhs()->accept(*this);
                useHexFlag = tempUseHexFlag;
                this->ss << ")";
            }
            this->ss << ")";
        } else {
            if (tempUseParentheses) this->ss << "(";
            node.getLhs()->accept(*this);
            if (node.getOperation() == "&") {
                this->ss << " and ";
            } else if (node.getOperation() == "|") {
                this->ss << " or ";
            } else if (node.getOperation() == "^") {
                this->ss << " xor ";
            } else throw std::runtime_error("Should not get here");
            node.getRhs()->accept(*this);
            if (tempUseParentheses) this->ss << ")";
        }
    }
}

void VHDLPrintVisitorHLS::visit(ArrayOperand &node) {
    useParenthesesFlag = true;
    this->ss << node.getArrayVar()->getName();
    this->ss << "(to_integer(unsigned(";
    node.getIdx()->accept(*this);
    this->ss << ")))";
}

void VHDLPrintVisitorHLS::visit(VariableOperand& node)
{
    bool isBoolean = node.getDataType()->isBoolean();
    if(isBoolean) {
        this->ss << "(";
    }
    if (node.getVariable()->isSubVar()) {
        if (node.getVariable()->getParent()->isCompoundType()) {
            this->ss << node.getVariable()->getParent()->getName() << "." << node.getVariable()->getName();
        } else if (node.getVariable()->getParent()->isArrayType()) {
            this->ss << node.getVariable()->getParent()->getName() << "(" << node.getVariable()->getName() << ")";
        } else throw std::runtime_error("Unknown Type for SubVar");
    } else {
        this->ss << node.getVariable()->getName();
    }
    if (isBoolean) {
        this->ss << " = '1')";
    }
}

void VHDLPrintVisitorHLS::visit(BoolValue &node) {
    if (node.getValue()) {
        this->ss << "\'1\'";
    } else {
        this->ss << "\'0\'";
    }
}

void VHDLPrintVisitorHLS::visit(DataSignalOperand &node) {
    bool isBoolean = node.getDataType()->isBoolean();
    if(isBoolean) {
        this->ss << "(";
    }
    this->ss << node.getDataSignal()->getPort()->getName() << "_sig";
    if (node.getDataSignal()->isSubVar()) {
        if (node.getDataSignal()->getParent()->isCompoundType()) {
            this->ss << "." << node.getDataSignal()->getName();
        } else if (node.getDataSignal()->getParent()->isArrayType()) {
            this->ss << "(" << node.getDataSignal()->getName() << ")";
        } else throw std::runtime_error("Unknown Type for SubVar");
    }
    if (isBoolean) {
        this->ss << " = '1')";
    }
}
