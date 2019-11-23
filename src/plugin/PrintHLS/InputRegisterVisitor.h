//
// Created by schauss on 26.08.19.
//

#ifndef SCAM_InputRegisterVisitor_H
#define SCAM_InputRegisterVisitor_H

#include <set>
#include "Stmts_all.h"
#include "StmtAbstractVisitor.h"
#include "Utilities.h"

namespace SCAM {

    struct Node {
        std::string operationName;
        std::string lhs;
        std::string rhs;
        Node* parent;
        std::vector<Node*> child;
    };

    class InputRegisterVisitor : public StmtAbstractVisitor {

    public:
        static bool getStmtTypes(Stmt *stmt, Port *port);

    private:
        explicit InputRegisterVisitor(Stmt *stmt, Port *port);

        bool arrayPort;
        Port *port;

        void visit(Arithmetic &node) override ;
        void visit(VariableOperand &node) override {};
        void visit(DataSignalOperand &node) override ;
        void visit(SyncSignal &node) override {};
        void visit(EnumValue &node) override {};
        void visit(Relational &node) override ;
        void visit(UnaryExpr &node) override ;
        void visit(IntegerValue &node) override {};
        void visit(UnsignedValue &node) override {};
        void visit(Logical &node) override ;
        void visit(FunctionOperand &node) override;
        void visit(CompoundExpr &node) override {};
        void visit(BoolValue &node) override {};
        void visit(CompoundValue& node) override {};
        void visit(PortOperand &node) override {};
        void visit(Assignment &node) override ;
        void visit(While &node) override {};
        void visit(If &node) override {};
        void visit(SectionOperand &node) override {};
        void visit(SectionValue &node) override {};
        void visit(ITE &node) override {};
        void visit(Bitwise &node) override ;
        void visit(Read &node) override {};
        void visit(Write &node) override {};
        void visit(Wait &node) override {};
        void visit(Peek &node) override {};
        void visit(Cast &node) override {};
        void visit(ArrayOperand &node) override ;
        void visit(ParamOperand &node) override {};
        void visit(Return &node) override {};
        void visit(Notify &node) override {};
        void visit(ArrayExpr &node) override {};
    };

}


#endif //SCAM_InputRegisterVisitor_H