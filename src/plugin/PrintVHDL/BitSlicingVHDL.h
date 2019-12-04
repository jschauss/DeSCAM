//
// Created by johannes on 29.11.19.
//

#ifndef DESCAM_BITSLICINGVHDL_H
#define DESCAM_BITSLICINGVHDL_H

#include <memory>

#include "PrintStmt.h"
#include "OtherUtils.h"

namespace SCAM { namespace VHDL {

    struct Node {
        StmtType type = StmtType::UNKNOWN;
        SubTypeBitwise subType = SubTypeBitwise::UNKNOWN;
        unsigned int value;
        unsigned int firstBit;
        unsigned int lastBit;
        std::string name;
        std::vector<std::shared_ptr<Node>> child;
    };

    class BitSlicingVHDL : public StmtAbstractVisitor {
    public:
        explicit BitSlicingVHDL(Stmt *stmt);

        bool isSlicingOp();

        std::string getOpAsString();

    private:
        bool slicing(Node *node);

        bool sliceWithShift(Node *node);

        bool sliceWithoutShift(Node *node);

        bool shiftWithConstant(Node *node);

        std::string getString(Node *node);

        bool getRange(unsigned int number, unsigned int &firstBit, unsigned int &lastBit);

        std::shared_ptr<Node> actualNode;

        void visit(Arithmetic &node) override;

        void visit(VariableOperand &node) override;

        void visit(DataSignalOperand &node) override;

        void visit(SyncSignal &node) override {};

        void visit(EnumValue &node) override {};

        void visit(Relational &node) override;

        void visit(UnaryExpr &node) override;

        void visit(IntegerValue &node) override;

        void visit(UnsignedValue &node) override;

        void visit(Logical &node) override;

        void visit(FunctionOperand &node) override {};

        void visit(CompoundExpr &node) override {};

        void visit(BoolValue &node) override {};

        void visit(CompoundValue &node) override {};

        void visit(PortOperand &node) override {};

        void visit(Assignment &node) override;

        void visit(While &node) override {};

        void visit(If &node) override {};

        void visit(SectionOperand &node) override {};

        void visit(SectionValue &node) override {};

        void visit(ITE &node) override {};

        void visit(Bitwise &node) override;

        void visit(Read &node) override {};

        void visit(Write &node) override {};

        void visit(Cast &node) override {};

        void visit(ArrayOperand &node) override;

        void visit(ParamOperand &node) override;

        void visit(Return &node) override {};

        void visit(Notify &node) override {};

        void visit(Wait &node) override {};

        void visit(Peek &node) override {};

        void visit(ArrayExpr &node) override {};
    };

} }

#endif //DESCAM_BITSLICINGVHDL_H