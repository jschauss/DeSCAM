//
// Created by johannes on 02.11.19.
//

#include "PrintStatement.h"
#include "Utilities.h"
#include "VHDLWrapperOneClkCycle.h"

using namespace SCAM::HLSPlugin::VHDLWrapper;

std::map<std::string, std::string> VHDLWrapperOneClkCycle::printModel(Model *model) {
    for (auto &module : model->getModules()) {
        this->propertySuite = module.second->getPropertySuite();
        this->currentModule = module.second;
        hlsModule = std::make_unique<OperationModuleInterface>(propertySuite, currentModule);
        signalFactory = std::make_unique<SignalFactory>(propertySuite, currentModule, hlsModule.get(), true);

        pluginOutput.insert(std::make_pair(model->getName() + "_types.vhd", printTypes(model)));
        pluginOutput.insert(std::make_pair(propertySuite->getName() + ".vhd", printModule(model)));
    }
    return pluginOutput;
}

void VHDLWrapperOneClkCycle::entity(std::stringstream &ss) {
    // Print Entity
    ss << "entity " + propertySuite->getName() + "_module is\n";
    ss << "port(\n";

    auto printPortSignals = [&ss](std::set<DataSignal* > const& dataSignals, bool lastSet) {
        for (auto dataSignal = dataSignals.begin(); dataSignal != dataSignals.end(); ++dataSignal) {
            ss << "\t" << (*dataSignal)->getFullName() << ": " << (*dataSignal)->getPort()->getInterface()->getDirection()
               << " " << SignalFactory::getDataTypeName(*dataSignal, false);
            if (std::next(dataSignal) != dataSignals.end() || !lastSet) {
                ss << ";\n";
            }
        }
    };
    printPortSignals(signalFactory->getInputs(), false);
    printPortSignals(signalFactory->getOutputs(), false);
    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\t" << notifySignal->getName() << ": out std_logic;\n";
    }
    for (const auto syncSignal : propertySuite->getSyncSignals()) {
        ss << "\t" << syncSignal->getName() << ": in std_logic;\n";
    }
    printPortSignals(signalFactory->getControlSignals(), true);

    ss << "\n);\n";
    ss << "end " + propertySuite->getName() << "_module;\n\n";
}

// Print Signals
void VHDLWrapperOneClkCycle::signals(std::stringstream &ss) {
    auto printVars = [&ss](
            std::set<Variable *> const& vars,
            Style const& style,
            std::string const& prefix,
            std::string const& suffix,
            bool const& asVector) {
        for (const auto& var : vars) {
            ss << "\tsignal " << prefix << SignalFactory::getName(var, style, suffix)
               << ": " << SignalFactory::getDataTypeName(var, asVector) << ";\n";
        }
    };

    auto printSignal = [&ss](
            std::set<DataSignal *> const& signals,
            Style const& style,
            std::string const& suffix,
            bool const& asVector) {
        for (const auto& signal : signals) {
            ss << "\tsignal " << SignalFactory::getName(signal, style, suffix)
               << ": " << SignalFactory::getDataTypeName(signal, asVector) << ";\n";
        }
    };

    ss << "\n\t-- Internal Registers\n";
    printVars(Utilities::getParents(signalFactory->getInternalRegisterOut()),Style::UL, "", "", false);
    printVars(signalFactory->getInternalRegisterOut(),Style::UL, "out_", "", true);
    printVars(signalFactory->getOutputRegister(), Style::DOT, "", "", false);

    ss << "\n\t-- Operation Module Inputs\n";
    printSignal(Utilities::getSubVars(signalFactory->getOperationModuleInputs()),
            Style::UL, "_in", true);
    printVars({signalFactory->getActiveOperation()}, Style::DOT, "", "_in", true);

    ss << "\n\t-- Module Outputs\n";
    printSignal(Utilities::getSubVars(signalFactory->getOperationModuleOutputs()),
            Style::UL, "_out", true);
    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\tsignal " << notifySignal->getName() << "_out: std_logic;\n";
    }

    ss << "\n\t-- Monitor Signals\n";
    printVars(signalFactory->getMonitorSignals(), Style::DOT, "", "", false);

}

void VHDLWrapperOneClkCycle::component(std::stringstream& ss) {
    // Print Component
    ss << "\n\tcomponent operations is\n";
    ss << "\tport(\n";

    auto printComponentSignal = [&ss](std::set<DataSignal *> const& signals, std::string const& prefix) {
        for (const auto& signal : signals) {
            bool vectorType = signal->getDataType()->isInteger() || signal->getDataType()->isUnsigned();
            std::string suffix = (vectorType ? "_V" : "");
            ss << "\t\t" << prefix << SignalFactory::getName(signal, Style::UL, suffix) << ": "
               << signal->getPort()->getInterface()->getDirection() << " " << SignalFactory::getDataTypeName(signal, true)
               << ";\n";
        }
    };

    auto printComponentVars = [&ss](std::set<Variable *> const& vars, std::string const& prefix) {
        for (const auto& var : vars) {
            std::string type = var->getDataType()->getName();
            std::string suffix = (type=="int" || type=="unsigned" ? "_V" : "");
            ss << "\t\t" << prefix + "_" << SignalFactory::getName(var, Style::UL, suffix) << ": "
               << prefix << " " << SignalFactory::getDataTypeName(var, true)
               << ";\n";
        }
    };

    printComponentSignal(signalFactory->getControlSignals(), "ap_");
    printComponentSignal(Utilities::getSubVars(signalFactory->getOperationModuleInputs()), "");
    printComponentSignal(Utilities::getSubVars(signalFactory->getOperationModuleOutputs()), "");
    printComponentVars(signalFactory->getInternalRegisterOut(), "out");

    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\t\t" << notifySignal->getName() << ": out std_logic;\n";
    }

    const auto& activeOp = signalFactory->getActiveOperation();
    ss << "\t\t" << activeOp->getFullName() << ": in " << SignalFactory::getDataTypeName(activeOp, true) << "\n";

    ss << "\t);\n"
       << "\tend component;\n";
}

// Print Component Instantiation
void VHDLWrapperOneClkCycle::componentInst(std::stringstream& ss) {
    ss << "\toperations_inst: operations\n"
       << "\tport map(\n";

    auto printComponentInstSignal = [&ss](
            std::set<DataSignal *> const& signals,
            std::string const& prefix,
            std::string const& suffix) {
        for (const auto& signal : signals) {
            std::string type = signal->getDataType()->getName();
            std::string moduleSuffix = (type == "int" || type == "unsigned" ? "_V" : "");
            ss << "\t\t" << prefix << SignalFactory::getName(signal, Style::UL, moduleSuffix) << " => "
               << SignalFactory::getName(signal, Style::UL, suffix) << ",\n";
        }
    };

    auto printComponentInstVars = [&ss](std::set<Variable *> const& vars, std::string const& prefix) {
        for (const auto& var : vars) {
            std::string type = var->getDataType()->getName();
            std::string suffix = (type == "int" || type == "unsigned" ? "_V" : "");
            ss << "\t\t" << prefix << SignalFactory::getName(var, Style::UL, suffix) << " => "
               << prefix << SignalFactory::getName(var, Style::UL, "") << ",\n";
        }
    };

    printComponentInstSignal(signalFactory->getControlSignals(), "ap_", "");
    printComponentInstSignal(Utilities::getSubVars(signalFactory->getOperationModuleInputs()), "", "_in");
    printComponentInstSignal(Utilities::getSubVars(signalFactory->getOperationModuleOutputs()), "", "_out");
    printComponentInstVars(signalFactory->getInternalRegisterOut(), "out_");

    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\t\t" << notifySignal->getName() << " => " << notifySignal->getName() << "_out,\n";
    }

    const auto& activeOp = signalFactory->getActiveOperation();
    ss << "\t\t" << activeOp->getFullName() << " => " << SignalFactory::getName(activeOp, Style::UL, "_in") << "\n"
       << "\t);\n\n";
}

// Print Monitor
void VHDLWrapperOneClkCycle::monitor(std::stringstream &ss) {
    ss << "\t-- Monitor\n"
       << "\tprocess (" << sensitivityList() << ")\n"
       << "\tbegin\n"
       << "\t\tcase active_state is\n";

    std::set<std::string> waitStateNames;
    for (auto waitState : propertySuite->getWaitProperties()) {
        waitStateNames.insert(waitState->getName());
    }

    auto printAssumptions = [&ss](std::vector<Expr* > exprList) {
        if (exprList.empty()) {
            ss << "true";
        }
        for (auto expr = exprList.begin(); expr != exprList.end(); ++expr) {
            ss << PrintStatement::toString(*expr, true);
            if (std::next(expr) != exprList.end()) {
                ss << " and ";
            }
        }
    };

    for (const auto& state : propertySuite->getStates()) {
        bool noEndIf = false;
        bool skipAssumptions = false;
        ss << "\t\twhen st_" << state->getName() << " =>\n";
        auto properties = propertySuite->getSuccessorProperties(state);
        for (auto property = properties.begin(); property != properties.end(); ++property) {
            if (property == properties.begin()) {
                if (properties.size() == 1) {
                    noEndIf = true;
                } else {
                    ss << "\t\t\tif (";
                }
            } else if (std::next(property) == properties.end()) {
                ss << "\t\t\telse\n";
                skipAssumptions = true;
            } else {
                ss << "\t\t\telsif (";
            }
            if (!skipAssumptions) {
                printAssumptions((*property)->getAssumptionList());
                ss << ") then \n";
            }
            if (waitStateNames.find((*property)->getName()) == waitStateNames.end()) {
                ss << "\t\t\t\tactive_operation <= op_" << (*property)->getName() << ";\n"
                   << "\t\t\t\tnext_state <= st_" << (*property)->getNextState()->getName() << ";\n";
            } else {
                ss << "\t\t\t\tactive_operation <= op_state_wait;\n";
                ss << "\t\t\t\tnext_state <= active_state;\n";
            }
        }
        if (!noEndIf) {
            ss << "\t\t\tend if;\n";
        }
    }
    ss << "\t\tend case;\n"
       << "\tend process;\n\n";
}

void VHDLWrapperOneClkCycle::moduleOutputHandling(std::stringstream& ss)
{
    auto printOutputProcess = [&](DataSignal* dataSignal) {
        bool isEnum = dataSignal->isEnumType();
        bool hasOutputReg = hlsModule->hasOutputReg(dataSignal);
        std::string name;
        if (hasOutputReg) {
            name = SignalFactory::getName(hlsModule->getCorrespondingRegister(dataSignal), Style::DOT);
        } else {
            name = SignalFactory::getName(dataSignal, Style::DOT);
        }
        ss << "\t" << name << " <= "
           << (
                   isEnum ?
                   SignalFactory::vectorToEnum(dataSignal, "_out") :
                   SignalFactory::getName(dataSignal, Style::UL, "_out"))
           << ";\n";
    };
    ss << "\n\t-- Operation Module Outputs\n";
    for (const auto& out : Utilities::getSubVars(signalFactory->getOperationModuleOutputs())) {
        printOutputProcess(out);
    }

    ss << "\n\t-- Output Register to Output Mapping\n";
    for (const auto& out : signalFactory->getOperationModuleOutputs()) {
        if (hlsModule->hasOutputReg(out)) {
            if (hlsModule->isModuleSignal(out)) {
                for (const auto& sig : hlsModule->getCorrespondingTopSignals(out)) {
                    ss << "\t" << sig->getFullName() << " <= " << hlsModule->getCorrespondingRegister(out)->getFullName() << ";\n";
                }
            } else {
                ss << "\t" << out->getFullName() << " <= " << hlsModule->getCorrespondingRegister(out)->getFullName() << ";\n";
            }
        }
    }

    ss << "\n\t-- Internal Register\n";
    auto printOutputProcessRegs = [&](Variable* var) {
        bool isEnum = var->isEnumType();
        ss << "\t" << SignalFactory::getName(var, Style::DOT) << " <= "
           << (
                   isEnum ?
                   SignalFactory::vectorToEnum(var, "", "out_") :
                   "out_" + SignalFactory::getName(var, Style::UL, ""))
           << ";\n";
    };
    for (const auto& internalRegs : signalFactory->getInternalRegisterOut()) {
        printOutputProcessRegs(internalRegs);
    }

    ss << "\n\t-- Notify Signals\n";
    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\t" << notifySignal->getName() << " <= " << notifySignal->getName() << "_out;\n";
    }

    auto printModuleInputSignals = [this, &ss](std::set<DataSignal*> const& dataSignals) {
        for (const auto& dataSignal : dataSignals) {
            if (!dataSignal->getPort()->isArrayType()) {
                ss << "\t" << SignalFactory::getName(dataSignal, Style::UL) << "_in <= "
                   << (
                           dataSignal->isEnumType() ?
                           SignalFactory::enumToVector(dataSignal) :
                           SignalFactory::getName(dataSignal, Style::DOT))
                   << ";\n";
            }
        }
    };

    auto printModuleInputVars = [&ss](std::set<Variable*> const& vars, std::string const& prefix, std::string const& suffix) {
        for (const auto& var : vars) {
            ss << "\t" << prefix << SignalFactory::getName(var, Style::UL) << suffix << " <= "
               << (
                       var->isEnumType() ?
                       SignalFactory::enumToVector(var) :
                       SignalFactory::getName(var, Style::DOT))
               << ";\n";
        }
    };

    ss << "\n\t-- Operation Module Inputs\n";
    printModuleInputVars({signalFactory->getActiveOperation()}, "" , "_in");
    printModuleInputSignals(Utilities::getSubVars(signalFactory->getOperationModuleInputs()));

    for (const auto &arrayPort : hlsModule->getArrayPorts()) {
        uint32_t exprNumber = 0;
        for (const auto &expr : arrayPort.second) {
            ss << "\t\t" << arrayPort.first->getDataSignal()->getName() << "_" << exprNumber << "_in"
               << " <= " << arrayPort.first->getDataSignal()->getName() << "(to_integer(unsigned("
               << PrintStatement::toString(expr, false) << ")));\n";
            exprNumber++;
        }
    }
}

void VHDLWrapperOneClkCycle::controlProcess(std::stringstream &ss) {
    // Print Control Process
    ss << "\n\t-- Control process\n"
       << "\tprocess (clk, rst)\n"
       << "\tbegin\n"
       << "\t\tif (rst = '1') then\n"
       << "\t\t\tactive_state <= st_" << propertySuite->getResetProperty()->getNextState()->getName() << ";\n"
       << "\t\telsif (clk = '1' and clk'event) then\n"
       << "\t\t\tactive_state <= next_state;\n"
       << "\t\tend if;\n"
       << "\tend process;\n\n"
       << "end " << propertySuite->getName() << "_arch;\n";
}

std::string VHDLWrapperOneClkCycle::operationEnum()
{
    std::stringstream ss;
    ss << "\t-- Operations\n"
       << "\ttype " << propertySuite->getName() << "_operation_t is (";
    auto operations = propertySuite->getOperationProperties();
    for (auto op : operations) {
        ss << "op_" << op->getName() << ", ";
    }
    ss << "op_state_wait);\n\n";

    return ss.str();
}