//
// Created by johannes on 02.11.19.
//

#ifndef SCAM_PRINTVHDLFORHLS_H
#define SCAM_PRINTVHDLFORHLS_H

#include <memory>
#include <string>

#include "OperationModuleInterface.h"
#include "PluginFactory.h"
#include "SignalFactory.h"
#include "VHDLWrapper.h"

namespace SCAM { namespace HLSPlugin { namespace VHDLWrapper {

        class VHDLWrapperOneClkCycle : public VHDLWrapper {

        public:
            VHDLWrapperOneClkCycle() = default;
            ~VHDLWrapperOneClkCycle() = default;

        private:
            void entity(std::stringstream& ss) override ;
            void signals(std::stringstream& ss) override ;
            void component(std::stringstream& ss) override ;
            void componentInst(std::stringstream& ss) override ;
            void monitor(std::stringstream& ss) override ;
            void moduleOutputHandling(std::stringstream& ss) override ;
            void controlProcess(std::stringstream& ss) override ;
        };

}}}

#endif //SCAM_PRINTVHDLFORHLS_H
