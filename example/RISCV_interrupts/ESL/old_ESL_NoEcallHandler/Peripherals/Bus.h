//
// Created by Nawras Altaleb (nawras.altaleb89@gmail.com) on 13.10.18.
//

#ifndef BUS_H
#define BUS_H

#include "systemc"
#include "Interfaces.h"
#include "Memory_Interfaces.h"
#include "Defines.h"

#define SCAM 0

struct Bus: sc_module {
    blocking_in<CUtoME_IF> isa_bus_Port;
    blocking_out<MEtoCU_IF> bus_isa_Port;

    blocking_out<CUtoME_IF> BUStoMEM_port;
    blocking_in<MEtoCU_IF> MEMtoBUS_port;

    blocking_out<CUtoME_IF> BUStoCLINT_port;
    blocking_in<MEtoCU_IF> CLINTtoBUS_port;

    blocking_out<CUtoME_IF> BUStoPLIC_port;
    blocking_in<MEtoCU_IF> PLICtoBUS_port;

#ifdef CoreTempSensor_ON
    blocking_out<CPtoME_IF> BUStoCoreTempSensor_port;
    blocking_in<MEtoCP_IF> CoreTempSensortoBUS_port;
#endif

    CUtoME_IF CPtoME_data;
    MEtoCU_IF MEtoCP_data;
    bool rec;

    SC_CTOR(Bus) :
            BUStoMEM_port("BUStoMEM_port"),
            MEMtoBUS_port("MEMtoBUS_port"),
            BUStoCLINT_port("BUStoCLINT_port"),
            CLINTtoBUS_port("CLINTtoBUS_port"),
            BUStoPLIC_port("BUStoPLIC_port"),
            PLICtoBUS_port("PLICtoBUS_port"),
#ifdef CoreTempSensor_ON
    BUStoCoreTempSensor_port("BUStoCoreTempSensor_port"),
    CoreTempSensortoBUS_port("CoreTempSensortoBUS_port"),
#endif
            isa_bus_Port("isa_bus_Port"),
            bus_isa_Port("bus_isa_Port"),
            rec(false) {
        SC_THREAD(run);
    }

    void run() {
        while (true) {
            rec = isa_bus_Port->nb_read(CPtoME_data);
            if (rec) {
                if (CPtoME_data.addrIn >= MEM_START_ADDR && CPtoME_data.addrIn < MEM_END_ADDR) {
                    BUStoMEM_port->write(CPtoME_data);
                    if (CPtoME_data.req == ME_RD) {
                        MEMtoBUS_port->read(MEtoCP_data);
                        bus_isa_Port->write(MEtoCP_data);
                    }
                } else if (CPtoME_data.addrIn >= CLINT_START_ADDR && CPtoME_data.addrIn < CLINT_END_ADDR) {
                    BUStoCLINT_port->write(CPtoME_data);
                    if (CPtoME_data.req == ME_RD) {
                        CLINTtoBUS_port->read(MEtoCP_data);
                        bus_isa_Port->write(MEtoCP_data);
                    }
                } else if (CPtoME_data.addrIn >= PLIC_START_ADDR && CPtoME_data.addrIn < PLIC_END_ADDR) {
                    BUStoPLIC_port->write(CPtoME_data);
                    if (CPtoME_data.req == ME_RD) {
                        PLICtoBUS_port->read(MEtoCP_data);
                        bus_isa_Port->write(MEtoCP_data);
                    }
#ifdef CoreTempSensor_ON
                    } else if (CPtoME_data.addrIn >= CORETEMPSENSOR_START_ADDR && CPtoME_data.addrIn < CORETEMPSENSOR_END_ADDR) {
                BUStoCoreTempSensor_port->write(CPtoME_data);
                if (CPtoME_data.req == ME_RD) {
                    CoreTempSensortoBUS_port->read(MEtoCP_data);
                    bus_isa_Port->write(MEtoCP_data);
                }
#endif
                } else {
#if SCAM == 0
                    cout << "@BUS: Accessing out of bound. 0x" << std::hex << CPtoME_data.addrIn << ")" << endl;
                    sc_stop();
                    wait(SC_ZERO_TIME);
#endif
                }
            }
        }
    }
};

#endif
