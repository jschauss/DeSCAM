//
// Created by johannes on 02.11.19.
//

#include "PrintReset.h"
#include "PrintStatement.h"
#include "Utilities.h"
#include "VHDLWrapperMultiClkCycle.h"

using namespace SCAM::HLSPlugin::VHDLWrapper;

std::map<std::string, std::string> VHDLWrapperMultiClkCycle::printModel(Model *model) {
    for (auto &module : model->getModules()) {
        this->propertySuite = module.second->getPropertySuite();
        this->currentModule = module.second;
        hlsModule = std::make_unique<OperationModuleInterface>(propertySuite, currentModule);
        signalFactory = std::make_unique<SignalFactory>(propertySuite, currentModule, hlsModule.get(), false);

        pluginOutput.insert(std::make_pair(model->getName() + "_types.vhd", printTypes(model)));
        pluginOutput.insert(std::make_pair(propertySuite->getName() + ".vhd", printModule(model)));
    }
    return pluginOutput;
}

void VHDLWrapperMultiClkCycle::entity(std::stringstream &ss) {
    // Print Entity
    ss << "entity " << propertySuite->getName() << "_module is\n";
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
void VHDLWrapperMultiClkCycle::signals(std::stringstream &ss) {
    auto printVars = [&ss](
            std::set<Variable *> const& vars,
            Style const& style,
            std::string const& prefix,
            std::string const& suffix,
            bool const& vld,
            bool const& asVector) {
        for (const auto& var : vars) {
            ss << "\tsignal " << prefix << SignalFactory::getName(var, style, suffix)
               << ": " << SignalFactory::getDataTypeName(var, asVector) << ";\n";
            if (vld) {
                ss << "\tsignal " << prefix << SignalFactory::getName(var, style, "_vld") << ": std_logic;\n";
            }
        }
    };

    auto printSignal = [&ss](
            std::set<DataSignal *> const& signals,
            Style const& style,
            std::string const& suffix,
            bool const& vld,
            bool const& asVector) {
        for (const auto& signal : signals) {
            ss << "\tsignal " << SignalFactory::getName(signal, style, suffix)
               << ": " << SignalFactory::getDataTypeName(signal, asVector) << ";\n";
            if (vld) {
                ss << "\tsignal " << SignalFactory::getName(signal, style, "_vld") << ": std_logic;\n";
            }
        }
    };

    ss << "\n\t-- Internal Registers\n";
    printVars(Utilities::getParents(signalFactory->getInternalRegister()),
            Style::DOT, "", "", false, false);
    printVars(signalFactory->getInternalRegisterIn(),Style::UL, "in_", "", false, true);
    printVars(signalFactory->getInternalRegisterOut(),Style::UL, "out_", "", true, true);

    ss << "\n\t-- Input Registers\n";
    printSignal(Utilities::getSubVars(signalFactory->getOperationModuleInputs()),
            Style::UL, "_in", false, true);
    printVars({signalFactory->getActiveOperation()}, Style::DOT, "", "_in", false, true);

    ss << "\n\t-- Output Register\n";
    printVars(signalFactory->getOutputRegister(), Style::DOT, "", "", false, false);
    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\tsignal " << notifySignal->getName() << "_reg: std_logic;\n";
    }

    ss << "\n\t-- Module Outputs\n";
    printSignal(Utilities::getSubVars(signalFactory->getOperationModuleOutputs()),
            Style::UL, "_out", true, true);
    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\tsignal " << notifySignal->getName() << "_out: std_logic;\n";
        ss << "\tsignal " << notifySignal->getName() << "_vld: std_logic;\n";
    }

    ss << "\n\t-- Handshaking Protocol Signals (Communication between top and operations_inst)\n";
    printSignal(signalFactory->getHandshakingProtocolSignals(), Style::DOT, "_sig", false, false);
    ss << "\n\t-- Monitor Signals\n";
    printVars(signalFactory->getMonitorSignals(), Style::DOT, "", "", false, false);
}

void VHDLWrapperMultiClkCycle::component(std::stringstream& ss) {
    // Print Component
    ss << "\n\tcomponent operations is\n";
    ss << "\tport(\n";

    auto printComponentSignal = [&ss](std::set<DataSignal *> const& signals, std::string const& prefix, bool const& vld) {
        for (const auto& signal : signals) {
            bool vectorType = signal->getDataType()->isInteger() || signal->getDataType()->isUnsigned();
            std::string suffix = (vectorType ? "_V" : "");
            ss << "\t\t" << prefix << SignalFactory::getName(signal, Style::UL, suffix) << ": "
               << signal->getPort()->getInterface()->getDirection() << " " << SignalFactory::getDataTypeName(signal, true)
               << ";\n";
            if (vld) {
                ss << "\t\t" << prefix << SignalFactory::getName(signal, Style::UL, suffix + "_ap_vld")
                   << ": out std_logic;\n";
            }
        }
    };

    auto printComponentVars = [&ss](std::set<Variable *> const& vars, std::string const& prefix, bool const& vld) {
        for (const auto& var : vars) {
            std::string type = var->getDataType()->getName();
            std::string suffix = (type=="int" || type=="unsigned" ? "_V" : "");
            ss << "\t\t" << prefix + "_" << SignalFactory::getName(var, Style::UL, suffix) << ": "
               << prefix << " " << SignalFactory::getDataTypeName(var, true)
               << ";\n";
            if (vld) {
                ss << "\t\t" << prefix + "_" << SignalFactory::getName(var, Style::UL, suffix + "_ap_vld")
                   << ": out std_logic;\n";
            }
        }
    };

    printComponentSignal(signalFactory->getControlSignals(), "ap_", false);
    printComponentSignal(signalFactory->getHandshakingProtocolSignals(), "ap_", false);
    printComponentSignal(Utilities::getSubVars(signalFactory->getOperationModuleInputs()), "", false);
    printComponentSignal(Utilities::getSubVars(signalFactory->getOperationModuleOutputs()), "", true);
    printComponentVars(signalFactory->getInternalRegisterIn(), "in", false);
    printComponentVars(signalFactory->getInternalRegisterOut(), "out", true);

    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\t\t" << notifySignal->getName() << ": out std_logic;\n";
        ss << "\t\t" << notifySignal->getName() << "_ap_vld: out std_logic;\n";
    }

    const auto& activeOp = signalFactory->getActiveOperation();
    ss << "\t\t" << activeOp->getFullName() << ": in " << SignalFactory::getDataTypeName(activeOp, true) << "\n";

    ss << "\t);\n"
       << "\tend component;\n";
}

// Print Component Instantiation
void VHDLWrapperMultiClkCycle::componentInst(std::stringstream& ss) {
    ss << "\toperations_inst: operations\n"
       << "\tport map(\n";

    auto printComponentInstSignal = [&ss](
            std::set<DataSignal *> const& signals,
            std::string const& prefix,
            std::string const& suffix,
            bool const& vld) {
        for (const auto& signal : signals) {
            std::string type = signal->getDataType()->getName();
            std::string moduleSuffix = (type == "int" || type == "unsigned" ? "_V" : "");
            ss << "\t\t" << prefix << SignalFactory::getName(signal, Style::UL, moduleSuffix) << " => "
               << SignalFactory::getName(signal, Style::UL, suffix) << ",\n";
            if (vld) {
                ss << "\t\t" << prefix << SignalFactory::getName(signal, Style::UL, moduleSuffix + "_ap_vld")
                   << " => " << SignalFactory::getName(signal, Style::UL, "_vld") << ",\n";
            }
        }
    };

    auto printComponentInstVars = [&ss](std::set<Variable *> const& vars, std::string const& prefix, bool const& vld) {
        for (const auto& var : vars) {
            std::string type = var->getDataType()->getName();
            std::string suffix = (type=="int" || type=="unsigned" ? "_V" : "");
            ss << "\t\t" << prefix << SignalFactory::getName(var, Style::UL, suffix) << " => "
               << prefix << SignalFactory::getName(var, Style::UL, "") << ",\n";
            if (vld) {
                ss << "\t\t" << prefix << SignalFactory::getName(var, Style::UL, suffix + "_ap_vld")
                   << " => " << prefix << SignalFactory::getName(var, Style::UL, "_vld") << ",\n";
            }
        }
    };

    printComponentInstSignal(signalFactory->getControlSignals(), "ap_", "", false);
    printComponentInstSignal(signalFactory->getHandshakingProtocolSignals(), "ap_", "_sig", false);
    printComponentInstSignal(Utilities::getSubVars(signalFactory->getOperationModuleInputs()), "", "_in", false);
    printComponentInstSignal(Utilities::getSubVars(signalFactory->getOperationModuleOutputs()), "", "_out", true);
    printComponentInstVars(signalFactory->getInternalRegisterIn(), "in_", false);
    printComponentInstVars(signalFactory->getInternalRegisterOut(), "out_", true);

    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\t\t" << notifySignal->getName() << " => " << notifySignal->getName() << "_out,\n";
        ss << "\t\t" << notifySignal->getName() << "_ap_vld  => " << notifySignal->getName() << "_vld,\n";
    }

    const auto& activeOp = signalFactory->getActiveOperation();
    ss << "\t\t" << activeOp->getFullName() << " => " << SignalFactory::getName(activeOp, Style::UL, "_in") << "\n"
       << "\t);\n\n";
}

// Print Monitor
void VHDLWrapperMultiClkCycle::monitor(std::stringstream &ss) {
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
                   << "\t\t\t\tnext_state <= st_" << (*property)->getNextState()->getName() << ";\n"
                   << "\t\t\t\twait_state <= '0';\n";
            } else {
                ss << "\t\t\t\twait_state <= '1';\n";
            }
        }
        if (!noEndIf) {
            ss << "\t\t\tend if;\n";
        }
    }
    ss << "\t\tend case;\n"
       << "\tend process;\n\n";
}

void VHDLWrapperMultiClkCycle::moduleOutputHandling(std::stringstream& ss)
{
    // Print Output_Vld Processes
    auto printOutputProcess = [&](DataSignal* dataSignal) {
        bool hasOutputReg = hlsModule->hasOutputReg(dataSignal);
        bool isEnum = dataSignal->isEnumType();
        ss << "\tprocess (rst, " << SignalFactory::getName(dataSignal, Style::UL, "_vld") << ")\n"
           << "\tbegin\n"
           << "\t\tif (rst = \'1\') then\n"
           << "\t\t\t" << (hasOutputReg ? hlsModule->getCorrespondingRegister(dataSignal)->getFullName() : SignalFactory::getName(dataSignal, Style::DOT))
           << " <= " << getResetValue(dataSignal) << ";\n"
           << "\t\telsif (" << SignalFactory::getName(dataSignal, Style::UL, "_vld") << " = \'1\') then\n"
           << "\t\t\t" << (hasOutputReg ? hlsModule->getCorrespondingRegister(dataSignal)->getFullName() : SignalFactory::getName(dataSignal, Style::DOT))
           << " <= " << (isEnum ? SignalFactory::vectorToEnum(dataSignal, "_out") : SignalFactory::getName(dataSignal, Style::UL, "_out")) << ";\n"
           << "\t\tend if;\n"
           << "\tend process;\n\n";
    };
    ss << "\t-- Output_Vld Processes\n";
    for (const auto& out : Utilities::getSubVars(signalFactory->getOperationModuleOutputs())) {
        printOutputProcess(out);
    }

    auto printOutputProcessRegs = [&](Variable* var) {
        bool isEnum = var->isEnumType();
        ss << "\tprocess (rst, out_" << SignalFactory::getName(var, Style::UL, "_vld") << ")\n"
           << "\tbegin\n"
           << "\t\tif (rst = \'1\') then\n"
           << "\t\t\t" << SignalFactory::getName(var, Style::DOT) << " <= " << getResetValue(var) << ";\n"
           << "\t\telsif (out_" << SignalFactory::getName(var, Style::UL, "_vld") << " = \'1\') then\n"
           << "\t\t\t" << SignalFactory::getName(var, Style::DOT) << " <= " << (isEnum ?
                                                                                SignalFactory::vectorToEnum(var, "", "out_") :
                                                                                "out_" + SignalFactory::getName(var, Style::UL, "")) << ";\n"
           << "\t\tend if;\n"
           << "\tend process;\n\n";
    };
    for (const auto& internalRegs : signalFactory->getInternalRegisterOut()) {
        printOutputProcessRegs(internalRegs);
    }

    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\tprocess(" << notifySignal->getName() << "_vld)\n"
           << "\tbegin\n"
           << "\t\tif (" << notifySignal->getName() << "_vld = '1') then\n"
           << "\t\t\t" << notifySignal->getName() << "_reg <= " << notifySignal->getName() << "_out;\n"
           << "\t\tend if;\n"
           << "\tend process;\n\n";
    }

    // Print Output Processes
    ss << "\t-- Output Processes\n"
       << "\tprocess(rst, done_sig)\n"
       << "\tbegin\n"
       << "\t\tif (rst = '1') then\n";
    for (const auto& out : Utilities::getSubVars(signalFactory->getOutputs())) {
        if (hlsModule->hasOutputReg(out)) {
            ss << "\t\t\t" << SignalFactory::getName(out, Style::DOT) << " <= "
               << getResetValue(out) << ";\n";
        }
    }
    ss << "\t\telsif (done_sig = '1') then\n";
    for (const auto& out : signalFactory->getOperationModuleOutputs()) {
        if (hlsModule->hasOutputReg(out)) {
            if (hlsModule->isModuleSignal(out)) {
                for (const auto& sig : hlsModule->getCorrespondingTopSignals(out)) {
                    ss << "\t\t\t" << sig->getFullName() << " <= " << hlsModule->getCorrespondingRegister(out)->getFullName() << ";\n";
                }
            } else {
                ss << "\t\t\t" << out->getFullName() << " <= " << hlsModule->getCorrespondingRegister(out)->getFullName() << ";\n";
            }
        }
    }
    ss << "\t\tend if;\n"
       << "\tend process;\n\n";

    ss << "\tprocess(rst, done_sig, idle_sig)\n"
       << "\tbegin\n"
       << "\t\tif (rst = '1') then\n";
    for (const auto& commitment : propertySuite->getResetProperty()->getCommitmentList()) {
        std::string assignment = PrintResetNotify::toString(commitment);
        if (!assignment.empty()) {
            ss << "\t\t\t" << assignment;
        }
    }
    ss << "\t\telse\n"
       << "\t\t\tif (done_sig = '1') then\n";
    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\t\t\t\t" << notifySignal->getName() << " <= " << notifySignal->getName() << "_reg;\n";
    }
    ss << "\t\t\telsif (idle_sig = '1') then\n";
    for (const auto& port : currentModule->getPorts()) {
        if (port.second->getInterface()->isMasterOut()) {
            ss << "\t\t\t\t" << port.second->getName() << "_notify <= '0';\n";
        }
    }
    ss << "\t\t\telse\n";
    for (const auto& notifySignal : propertySuite->getNotifySignals()) {
        ss << "\t\t\t\t" << notifySignal->getName() << " <= '0';\n";
    }
    ss << "\t\t\tend if;\n"
       << "\t\tend if;\n"
       << "\tend process;\n\n";
}

void VHDLWrapperMultiClkCycle::controlProcess(std::stringstream& ss)
{
    auto printModuleInputSignals = [this, &ss](std::set<DataSignal*> const& dataSignals) {
        for (const auto& dataSignal : dataSignals) {
            if (!dataSignal->getPort()->isArrayType()) {
                ss << "\t\t\t\t" << SignalFactory::getName(dataSignal, Style::UL) << "_in <= "
                   << (dataSignal->isEnumType() ?
                       SignalFactory::enumToVector(dataSignal) :
                       SignalFactory::getName(dataSignal, Style::DOT))
                   << ";\n";
            }
        }
    };

    auto printModuleInputVars = [&ss](std::set<Variable*> const& vars, std::string const& prefix, std::string const& suffix) {
        for (const auto& var : vars) {
            ss << "\t\t\t\t" << prefix << SignalFactory::getName(var, Style::UL) << suffix << " <= "
               << (var->isEnumType() ?
                   SignalFactory::enumToVector(var) :
                   SignalFactory::getName(var, Style::DOT))
               << ";\n";
        }
    };

    // Print Control Process
    ss << "\t-- Control process\n"
       << "\tprocess (clk, rst)\n"
       << "\tbegin\n"
       << "\t\tif (rst = '1') then\n"
       << "\t\t\tstart_sig <= '0';\n"
       << "\t\t\tactive_state <= st_" << propertySuite->getResetProperty()->getNextState()->getName() << ";\n"
       << "\t\telsif (clk = '1' and clk'event) then\n"
       << "\t\t\tif ((idle_sig = '1' or ready_sig = '1') and wait_state = '0') then\n"
       << "\t\t\t\tstart_sig <= '1';\n"
       << "\t\t\t\tactive_state <= next_state;\n";

    printModuleInputVars({signalFactory->getActiveOperation()}, "" , "_in");
    printModuleInputSignals(Utilities::getSubVars(signalFactory->getOperationModuleInputs()));
    printModuleInputVars(signalFactory->getInternalRegisterIn(), "in_", "");

    for (const auto &arrayPort : hlsModule->getArrayPorts()) {
        uint32_t exprNumber = 0;
        for (const auto &expr : arrayPort.second) {
            ss << "\t\t\t\t" << arrayPort.first->getDataSignal()->getName() << "_" << exprNumber << "_in"
               << " <= " << arrayPort.first->getDataSignal()->getName() << "(to_integer(unsigned("
               << PrintStatement::toString(expr, false) << ")));\n";
            exprNumber++;
        }
    }

    ss << "\t\t\telsif ((idle_sig = '1' or  ready_sig = '1') and wait_state = '1') then\n"
       << "\t\t\t\tstart_sig <= '0';\n"
       << "\t\t\tend if;\n"
       << "\t\tend if;\n"
       << "\tend process;\n\n"
       << "end " << propertySuite->getName() << "_arch;\n";
}

std::string VHDLWrapperMultiClkCycle::operationEnum()
{
    std::stringstream ss;
    ss << "\t-- Operations\n"
               << "\ttype " << propertySuite->getName() << "_operation_t is (";
    auto operations = propertySuite->getOperationProperties();
    for (auto operation = operations.begin(); operation != operations.end(); ++ operation) {
        ss << "op_" << (*operation)->getName();
        if (std::next(operation) != operations.end()) {
            ss << ", ";
        }
    }
    ss << ");\n\n";

    return ss.str();
}