//
// Created by johannes on 10.09.19.
//

#include <memory>
#include <iomanip>
#include <cmath>

#include "NodePeekVisitor.h"
#include "PrintCondition.h"
#include "PrintBitOperations.h"
#include "Utilities.h"

using namespace SCAM::HLSPlugin::VHDLWrapper;

PrintCondition::PrintCondition(Stmt *stmt, unsigned int indentSize, unsigned int indentOffset) {
    this->slice = false;
    this->createString(stmt, indentSize, indentOffset);
}

std::string PrintCondition::toString(Stmt *stmt, unsigned int indentSize, unsigned int indentOffset) {
    PrintCondition printer(stmt, indentSize, indentOffset);
    return printer.getString();
}

std::string PrintCondition::getString() {
    return this->ss.str();
}


void PrintCondition::visit(Bitwise &node) {
    bool tempUseParentheses = useParenthesesFlag;
    useParenthesesFlag = true;

    std::unique_ptr<PrintBitOperations> printOperations = std::make_unique<PrintBitOperations>(&node);
    if (printOperations->isSlicingOp()) {
        this->ss << printOperations->getOpAsString();
    } else {
        if ((node.getOperation() == Utilities::subTypeBitwiseToString(SubTypeBitwise::LEFT_SHIFT)) ||
            (node.getOperation() == Utilities::subTypeBitwiseToString(SubTypeBitwise::RIGHT_SHIFT))) {
            if (node.getOperation() == Utilities::subTypeBitwiseToString(SubTypeBitwise::LEFT_SHIFT)) {
                this->ss << "shift_left(";
            } else if (node.getOperation() == Utilities::subTypeBitwiseToString(SubTypeBitwise::RIGHT_SHIFT)) {
                this->ss << "shift_right(";
            }

            bool subArithmeticOp = false;
            if (arithmeticOp) {
                subArithmeticOp = true;
            } else {
                arithmeticOp = true;
            }
            node.getLhs()->accept(*this);
            this->ss << ", ";
            if (!subArithmeticOp) {
                arithmeticOp = false;
            }

            NodePeekVisitor nodePeekRhs(node.getRhs());
            if (nodePeekRhs.nodePeekIntegerValue()) {
                this->ss << nodePeekRhs.nodePeekIntegerValue()->getValue();
            } else if (nodePeekRhs.nodePeekUnsignedValue()) {
                this->ss << nodePeekRhs.nodePeekUnsignedValue()->getValue();
            } else {
                this->ss << "to_integer(";
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

void PrintCondition::visit(ArrayOperand &node) {
    this->ss << node.getArrayOperand()->getOperandName();
    this->ss << "(to_integer(unsigned(";
    node.getIdx()->accept(*this);
    this->ss << ")))";
}

void PrintCondition::visit(Cast &node) {
    if (node.getDataType()->getName() == "unsigned") {
        NodePeekVisitor nodePeek(node.getSubExpr());
        if (nodePeek.nodePeekIntegerValue()) {
            node.getSubExpr()->accept(*this);
        } else {
            this->ss << "unsigned(";
            node.getSubExpr()->accept(*this);
            this->ss << ")";
        }
    } else if (node.getDataType()->getName() == "int") {
        NodePeekVisitor nodePeek(node.getSubExpr());
        if (nodePeek.nodePeekUnsignedValue()) {
            node.getSubExpr()->accept(*this);
        } else {
            this->ss << "signed(";
            node.getSubExpr()->accept(*this);
            this->ss << ")";
        }
    } else if (node.getDataType()->getName() == "bool") {
        this->ss << "boolean(";
        node.getSubExpr()->accept(*this);
        this->ss << ")";
    } else {
        this->ss << node.getDataType()->getName() << "(";
        node.getSubExpr()->accept(*this);
        this->ss << ")";
    }
    useParenthesesFlag = true;
}

void PrintCondition::visit(CompoundExpr &node) {
    auto valueMap = node.getValueMap();
    for (auto begin = valueMap.begin(); begin != valueMap.end(); ++begin) {
        NodePeekVisitor nodePeek(begin->second);
        if (nodePeek.nodePeekDataSignalOperand()) {
            // Print only parent, no need to enlist all the members (using record types)
            this->ss << nodePeek.nodePeekDataSignalOperand()->getDataSignal()->getParent()->getName();
            begin = --valueMap.end();
            break;
        } else {
            begin->second->accept(*this);
        }
        if(begin != --valueMap.end()) this->ss << ", ";
    }
}

void PrintCondition::visit(FunctionOperand &node) {
    this->ss << node.getOperandName() << "(";
    auto paramMap = node.getParamValueMap();
    for (auto parameter = paramMap.begin(); parameter != paramMap.end(); ++parameter) {
        parameter->second->accept(*this);
        if (std::next(parameter) != paramMap.end()) {
            this->ss << ", ";
        }
    }
    this->ss << ")";
}

void PrintCondition::visit(VariableOperand& node) {
    bool isBoolean = node.getDataType()->isBoolean();
    if(isBoolean) {
        this->ss << "(";
    }
    if (arithmeticOp) {
        if (node.getDataType()->isInteger()) {
            this->ss << "signed(";
        } else if (node.getDataType()->isUnsigned()) {
            this->ss << "unsigned(";
        }
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
    if(arithmeticOp) {
        this->ss << ")";
    }
    if (isBoolean) {
        this->ss << " = '1')";
    }
}

void PrintCondition::visit(BoolValue &node) {
    if (node.getValue()) {
        this->ss << "\'1\'";
    } else {
        this->ss << "\'0\'";
    }
}

void PrintCondition::visit(DataSignalOperand &node) {
    bool isBoolean = node.getDataType()->isBoolean();
    if (isBoolean) {
        this->ss << "(";
    }
    if (arithmeticOp) {
        if (node.getDataType()->isInteger()) {
            this->ss << "signed(";
        } else if (node.getDataType()->isUnsigned()) {
            this->ss << "unsigned(";
        }
    }
    this->ss << node.getDataSignal()->getPort()->getName() << "_sig";
    if (node.getDataSignal()->isSubVar()) {
        if (node.getDataSignal()->getParent()->isCompoundType()) {
            this->ss << "." << node.getDataSignal()->getName();
        } else if (node.getDataSignal()->getParent()->isArrayType()) {
            this->ss << "(" << node.getDataSignal()->getName() << ")";
        } else throw std::runtime_error("Unknown Type for SubVar");
    }
    if(arithmeticOp) {
        this->ss << ")";
    }
    if (isBoolean) {
        this->ss << " = '1')";
    }
}

void PrintCondition::visit(Arithmetic &node) {
    bool subArithmeticOp = false;
    if (arithmeticOp) {
        subArithmeticOp = true;
    } else {
        arithmeticOp = true;
    }
    if (node.getOperation() == "*") {
        NodePeekVisitor nodePeekLhs(node.getLhs());
        NodePeekVisitor nodePeekRhs(node.getRhs());
        if (nodePeekLhs.isConstTypeNode() || nodePeekRhs.isConstTypeNode()) {
            if (nodePeekLhs.nodePeekUnsignedValue() && (nodePeekLhs.nodePeekUnsignedValue()->getValue() == 2)) {
                node.getRhs()->accept(*this);
                this->ss << " + ";
                node.getRhs()->accept(*this);
            } else if (nodePeekRhs.nodePeekUnsignedValue() &&
                    (nodePeekRhs.nodePeekUnsignedValue()->getValue() == 2)) {
                node.getLhs()->accept(*this);
                this->ss << " + ";
                node.getLhs()->accept(*this);
            } else
            if (nodePeekLhs.nodePeekUnsignedValue() &&
                    Utilities::isPowerOfTwo(nodePeekLhs.nodePeekUnsignedValue()->getValue())) {
                //lShiftByConst
                this->ss << "shift_left(";
                node.getRhs()->accept(*this);
                this->ss << ", ";
                this->ss << Utilities::bitPosition(nodePeekLhs.nodePeekUnsignedValue()->getValue());
                this->ss << ")";
            } else if (nodePeekLhs.nodePeekIntegerValue() &&
                    (nodePeekLhs.nodePeekIntegerValue()->getValue() > 0) &&
                    Utilities::isPowerOfTwo(nodePeekLhs.nodePeekIntegerValue()->getValue())) {
                //lShiftByConst
                this->ss << "shift_left(";
                node.getRhs()->accept(*this);
                this->ss << ", ";
                this->ss << Utilities::bitPosition(nodePeekLhs.nodePeekIntegerValue()->getValue());
                this->ss << ")";
            } else if (nodePeekRhs.nodePeekUnsignedValue() &&
                    Utilities::isPowerOfTwo(nodePeekRhs.nodePeekUnsignedValue()->getValue())) {
                //lShiftByConst
                this->ss << "shift_left(";
                node.getLhs()->accept(*this);
                this->ss << ", ";
                this->ss << Utilities::bitPosition(nodePeekRhs.nodePeekIntegerValue()->getValue());
                this->ss << ")";
            } else if (nodePeekRhs.nodePeekIntegerValue() &&
                    (nodePeekRhs.nodePeekIntegerValue()->getValue() > 0) &&
                    Utilities::isPowerOfTwo(nodePeekRhs.nodePeekIntegerValue()->getValue())) {
                //lShiftByConst
                this->ss << "shift_left(";
                node.getLhs()->accept(*this);
                this->ss << ", ";
                this->ss << Utilities::bitPosition(nodePeekRhs.nodePeekIntegerValue()->getValue());
                this->ss << ")";
            } else {
                node.getLhs()->accept(*this);
                this->ss << " * ";
                node.getRhs()->accept(*this);
            }
        } else {
            node.getLhs()->accept(*this);
            this->ss << " * ";
            node.getRhs()->accept(*this);
        }
    } else {
        node.getLhs()->accept(*this);
        if (node.getOperation() == "%") {
            this->ss << " rem ";
        } else {
            this->ss << " " << node.getOperation() << " ";
        }
        node.getRhs()->accept(*this);
    }
    if (!subArithmeticOp) {
        arithmeticOp = false;
    }
}

void PrintCondition::visit(Relational &node) {
    std::unique_ptr<PrintBitOperations> sliceOp;
    if (NodePeekVisitor::nodePeekBitwise(node.getRhs())) {
        auto rhs = dynamic_cast<Bitwise *>(node.getRhs());
        sliceOp = std::make_unique<PrintBitOperations>(rhs);
        if (sliceOp->isSlicingOp()) {
            slice = true;
        }
    } else if (NodePeekVisitor::nodePeekBitwise(node.getLhs())) {
        auto lhs = dynamic_cast<Bitwise *>(node.getLhs());
        sliceOp = std::make_unique<PrintBitOperations>(lhs);
        if (sliceOp->isSlicingOp()) {
            slice = true;
        }
    }
    if (slice) {
        firstBit = sliceOp->getFirstBit();
        lastBit = sliceOp->getLastBit();
    }
    node.getLhs()->accept(*this);
    if (node.getOperation() == "==") {
        this->ss << " = ";
    } else if (node.getOperation() == "!=") {
        this->ss << " /= ";
    } else {
        this->ss << " " << node.getOperation() << " ";
    }
    node.getRhs()->accept(*this);
    slice = false;
}

void PrintCondition::visit(IntegerValue &node) {
    if (slice) {
        printBinaryVector(node.getValue());
    } else if (useHexFlag)
        this->ss << "x\"" << std::setfill ('0') << std::setw(8) << std::hex << node.getValue() << std::dec << "\"";
    else {
        this->ss << "to_signed(";
        this->ss << node.getValue();
        this->ss << ", 32)";
    }
}

void PrintCondition::visit(UnsignedValue &node) {
    if (slice) {
        printBinaryVector(node.getValue());
    } else if (useHexFlag)
        this->ss << "x\"" << std::setfill ('0') << std::setw(8) << std::hex << node.getValue() << std::dec << "\"";
    else {
        this->ss << "to_unsigned(";
        this->ss << node.getValue();
        this->ss << ", 32)";
    }
}

void PrintCondition::visit(UnaryExpr &node) {
    if(node.getOperation() == "~") {
        this->ss << "not(";
    } else {
        this->ss << node.getOperation() << "(";
    }
    node.getExpr()->accept(*this);
    this->ss << ")";
}

void PrintCondition::visit(SyncSignal &node) {
    this->ss << "(" << node.getPort()->getName() << "_sync = '1')";
}

void PrintCondition::printBinaryVector(const unsigned int &value) {
    unsigned int tmpLastBit = lastBit;
    this->ss << "\"";
    do {
        if (static_cast<unsigned int>(pow(2, tmpLastBit)) & value) {
            this->ss << "1";
        } else {
            this->ss << "0";
        }
    } while (tmpLastBit-- > firstBit);
    this->ss << "\"";
}
