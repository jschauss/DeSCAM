//
// Created by tobias on 05.12.18.
//

#include "Notify.h"
#include "NodePeekVisitor.h"

SCAM::Notify::Notify(SCAM::Port *port) :
        port(port),
        Expr(DataTypes::getDataType("bool")) {
}

SCAM::Port *SCAM::Notify::getPort() const {
    return port;
}

void SCAM::Notify::accept(SCAM::StmtAbstractVisitor &visitor) {
    visitor.visit(*this);
}

bool SCAM::Notify::operator==(const SCAM::Stmt &other) const {
    if (this == &other) return true;
    if (NodePeekVisitor::nodePeekNotify(const_cast<Stmt *>(&other)) == nullptr) return false;
    auto thisPtr = (Notify *) this;
    auto otherPtr = (const Notify *) &other;
    return (thisPtr->getPort() == otherPtr->getPort());
}

