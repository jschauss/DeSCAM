* 
* ******************************************************************************
* *                                                                            *
* *                   Copyright (C) 2004-2011, Nangate Inc.                    *
* *                           All rights reserved.                             *
* *                                                                            *
* * Nangate and the Nangate logo are trademarks of Nangate Inc.                *
* *                                                                            *
* * All trademarks, logos, software marks, and trade names (collectively the   *
* * "Marks") in this program are proprietary to Nangate or other respective    *
* * owners that have granted Nangate the right and license to use such Marks.  *
* * You are not permitted to use the Marks without the prior written consent   *
* * of Nangate or such third party that may own the Marks.                     *
* *                                                                            *
* * This file has been provided pursuant to a License Agreement containing     *
* * restrictions on its use. This file contains valuable trade secrets and     *
* * proprietary information of Nangate Inc., and is protected by U.S. and      *
* * international laws and/or treaties.                                        *
* *                                                                            *
* * The copyright notice(s) in this file does not indicate actual or intended  *
* * publication of this file.                                                  *
* *                                                                            *
* *     NGLibraryCreator, v2010.08-HR32-SP3-2010-08-05 - build 1009061800      *
* *                                                                            *
* ******************************************************************************
* 
* 
* Running on brazil06.nangate.com.br for user Giancarlo Franciscatto (gfr).
* Local time is now Tue, 4 Jan 2011, 14:44:41.
* Main process id is 1680.
*
********************************************************************************
*                                                                              *
* Cellname:   LS_LHEN_X1.                                                      *
*                                                                              *
* Technology: NCSU FreePDK 45nm.                                               *
* Format:     Cdl.                                                             *
*                                                                              *
* Written on brazil06.nangate.com.br for user Giancarlo Franciscatto (gfr)     *
* at 14:44:41 on Tue, 4 Jan 2011.                                              *
*                                                                              *
********************************************************************************
.SUBCKT LS_LHEN_X1 VDD VSS A VDDL ISOLN Z
*.PININFO VDD:P VDDL:P VSS:G A:I ISOLN:I Z:O 
*.EQN Z=(A * ISOLN)
M_M9 N_VDDL_M0_d N_A_M0_g N_4_M0_s N_VDDL_M0_b PMOS_VTL L=5e-08 W=1.9e-07
M_M10 N_6_M1_d N_4_M1_g N_VDDL_M0_d N_VDDL_M0_b PMOS_VTL L=5e-08 W=1.9e-07
M_M11 N_VDD_M2_d N_8_M2_g N_7_M2_s N_VDD_M2_b PMOS_VTL L=5e-08 W=1.35e-07
M_M12 N_8_M3_d N_7_M3_g N_VDD_M2_d N_VDD_M2_b PMOS_VTL L=5e-08 W=1.35e-07
M_M13 N_10_M4_d N_ISOLN_M4_g N_VDD_M4_s N_VDD_M2_b PMOS_VTL L=5e-08 W=2.3e-07
M_M14 N_VDD_M5_d N_8_M5_g N_10_M4_d N_VDD_M2_b PMOS_VTL L=5e-08 W=2.3e-07
M_M15 N_Z_M6_d N_10_M6_g N_VDD_M5_d N_VDD_M2_b PMOS_VTL L=5e-08 W=2.3e-07
M_M0 N_VSS_M7_d N_A_M7_g N_4_M7_s N_VSS_M7_b NMOS_VTL L=5e-08 W=9e-08
M_M1 N_6_M8_d N_4_M8_g N_VSS_M7_d N_VSS_M7_b NMOS_VTL L=5e-08 W=9e-08
M_M2 12 N_ISOLN_M9_g N_VSS_M9_s N_VSS_M7_b NMOS_VTL L=5e-08 W=9e-08
M_M3 N_7_M10_d N_6_M10_g 12 N_VSS_M7_b NMOS_VTL L=5e-08 W=9e-08
M_M4 13 N_4_M11_g N_8_M11_s N_VSS_M7_b NMOS_VTL L=5e-08 W=9e-08
M_M5 N_VSS_M12_d N_ISOLN_M12_g 13 N_VSS_M7_b NMOS_VTL L=5e-08 W=9e-08
M_M6 14 N_ISOLN_M13_g N_10_M13_s N_VSS_M7_b NMOS_VTL L=5e-08 W=1.4e-07
M_M7 N_VSS_M14_d N_8_M14_g 14 N_VSS_M7_b NMOS_VTL L=5e-08 W=1.4e-07
M_M8 N_Z_M15_d N_10_M15_g N_VSS_M14_d N_VSS_M7_b NMOS_VTL L=5e-08 W=9e-08
C_x_PM_LS_LHEN_X1%VDD_c0 x_PM_LS_LHEN_X1%VDD_49 VSS 0.0228456f
C_x_PM_LS_LHEN_X1%VDD_c1 x_PM_LS_LHEN_X1%VDD_46 VSS 0.00570267f
C_x_PM_LS_LHEN_X1%VDD_c2 x_PM_LS_LHEN_X1%VDD_45 VSS 0.0036036f
C_x_PM_LS_LHEN_X1%VDD_c3 x_PM_LS_LHEN_X1%VDD_44 VSS 0.00292673f
C_x_PM_LS_LHEN_X1%VDD_c4 x_PM_LS_LHEN_X1%VDD_43 VSS 0.0108319f
C_x_PM_LS_LHEN_X1%VDD_c5 x_PM_LS_LHEN_X1%VDD_42 VSS 0.2334f
C_x_PM_LS_LHEN_X1%VDD_c6 x_PM_LS_LHEN_X1%VDD_33 VSS 0.261446f
C_x_PM_LS_LHEN_X1%VDD_c7 x_PM_LS_LHEN_X1%VDD_30 VSS 0.0668431f
C_x_PM_LS_LHEN_X1%VDD_c8 x_PM_LS_LHEN_X1%VDD_27 VSS 0.0210677f
C_x_PM_LS_LHEN_X1%VDD_c9 N_VDD_M4_s VSS 0.0303685f
C_x_PM_LS_LHEN_X1%VDD_c10 x_PM_LS_LHEN_X1%VDD_21 VSS 0.0385059f
C_x_PM_LS_LHEN_X1%VDD_c11 N_VDD_M2_d VSS 0.0293886f
C_x_PM_LS_LHEN_X1%VDD_c12 x_PM_LS_LHEN_X1%VDD_15 VSS 0.12287f
C_x_PM_LS_LHEN_X1%VDD_c13 x_PM_LS_LHEN_X1%VDD_14 VSS 0.0192462f
C_x_PM_LS_LHEN_X1%VDD_c14 x_PM_LS_LHEN_X1%VDD_10 VSS 0.706493f
R_x_PM_LS_LHEN_X1%VDD_r15 N_VDD_M2_b x_PM_LS_LHEN_X1%VDD_49 0.13879 
R_x_PM_LS_LHEN_X1%VDD_r16 N_VDD_M2_b x_PM_LS_LHEN_X1%VDD_43 0.138595 
R_x_PM_LS_LHEN_X1%VDD_r17 N_VDD_M2_b x_PM_LS_LHEN_X1%VDD_42 0.138985 
R_x_PM_LS_LHEN_X1%VDD_r18 N_VDD_M2_b x_PM_LS_LHEN_X1%VDD_33 0.13879 
R_x_PM_LS_LHEN_X1%VDD_r19 x_PM_LS_LHEN_X1%VDD_33 VDD 3.84471 
R_x_PM_LS_LHEN_X1%VDD_r20 x_PM_LS_LHEN_X1%VDD_32 x_PM_LS_LHEN_X1%VDD_46 0.132285 
R_x_PM_LS_LHEN_X1%VDD_r21 x_PM_LS_LHEN_X1%VDD_49 x_PM_LS_LHEN_X1%VDD_32 0.558824 
R_x_PM_LS_LHEN_X1%VDD_r22 x_PM_LS_LHEN_X1%VDD_30 x_PM_LS_LHEN_X1%VDD_46 0.0680382 
R_x_PM_LS_LHEN_X1%VDD_r23 N_VDD_M5_d x_PM_LS_LHEN_X1%VDD_30 0.502102 
R_x_PM_LS_LHEN_X1%VDD_r24 x_PM_LS_LHEN_X1%VDD_28 x_PM_LS_LHEN_X1%VDD_45 0.087517 
R_x_PM_LS_LHEN_X1%VDD_r25 x_PM_LS_LHEN_X1%VDD_27 x_PM_LS_LHEN_X1%VDD_46 0.132285 
R_x_PM_LS_LHEN_X1%VDD_r26 x_PM_LS_LHEN_X1%VDD_27 x_PM_LS_LHEN_X1%VDD_28 0.625882 
R_x_PM_LS_LHEN_X1%VDD_r27 x_PM_LS_LHEN_X1%VDD_23 x_PM_LS_LHEN_X1%VDD_45 0.122195 
R_x_PM_LS_LHEN_X1%VDD_r28 x_PM_LS_LHEN_X1%VDD_23 N_VDD_M4_s 0.882941 
R_x_PM_LS_LHEN_X1%VDD_r29 x_PM_LS_LHEN_X1%VDD_22 x_PM_LS_LHEN_X1%VDD_44 0.0731438 
R_x_PM_LS_LHEN_X1%VDD_r30 x_PM_LS_LHEN_X1%VDD_21 x_PM_LS_LHEN_X1%VDD_45 0.087517 
R_x_PM_LS_LHEN_X1%VDD_r31 x_PM_LS_LHEN_X1%VDD_21 x_PM_LS_LHEN_X1%VDD_22 1.02824 
R_x_PM_LS_LHEN_X1%VDD_r32 x_PM_LS_LHEN_X1%VDD_17 x_PM_LS_LHEN_X1%VDD_44 0.145286 
R_x_PM_LS_LHEN_X1%VDD_r33 x_PM_LS_LHEN_X1%VDD_17 N_VDD_M2_d 0.502143 
R_x_PM_LS_LHEN_X1%VDD_r34 x_PM_LS_LHEN_X1%VDD_15 x_PM_LS_LHEN_X1%VDD_44 0.0731438 
R_x_PM_LS_LHEN_X1%VDD_r35 x_PM_LS_LHEN_X1%VDD_15 x_PM_LS_LHEN_X1%VDD_43 3.28588 
R_x_PM_LS_LHEN_X1%VDD_r36 x_PM_LS_LHEN_X1%VDD_14 N_VDD_M2_b 0.140282 
R_x_PM_LS_LHEN_X1%VDD_r37 x_PM_LS_LHEN_X1%VDD_42 x_PM_LS_LHEN_X1%VDD_14 7.68941 
R_x_PM_LS_LHEN_X1%VDD_r38 x_PM_LS_LHEN_X1%VDD_10 VDD 11.0647 
C_x_PM_LS_LHEN_X1%VSS_c0 x_PM_LS_LHEN_X1%VSS_57 VSS 0.00294746f
C_x_PM_LS_LHEN_X1%VSS_c1 x_PM_LS_LHEN_X1%VSS_56 VSS 0.00276597f
C_x_PM_LS_LHEN_X1%VSS_c2 x_PM_LS_LHEN_X1%VSS_55 VSS 0.00276597f
C_x_PM_LS_LHEN_X1%VSS_c3 x_PM_LS_LHEN_X1%VSS_54 VSS 0.00293741f
C_x_PM_LS_LHEN_X1%VSS_c4 x_PM_LS_LHEN_X1%VSS_52 VSS 0.2334f
C_x_PM_LS_LHEN_X1%VSS_c5 N_VSS_M7_b VSS 0.261464f
C_x_PM_LS_LHEN_X1%VSS_c6 x_PM_LS_LHEN_X1%VSS_42 VSS 0.0316988f
C_x_PM_LS_LHEN_X1%VSS_c7 N_VSS_M14_d VSS 0.0382121f
C_x_PM_LS_LHEN_X1%VSS_c8 x_PM_LS_LHEN_X1%VSS_36 VSS 0.0434429f
C_x_PM_LS_LHEN_X1%VSS_c9 N_VSS_M12_d VSS 0.0332966f
C_x_PM_LS_LHEN_X1%VSS_c10 x_PM_LS_LHEN_X1%VSS_28 VSS 0.0969274f
C_x_PM_LS_LHEN_X1%VSS_c11 N_VSS_M9_s VSS 0.0465138f
C_x_PM_LS_LHEN_X1%VSS_c12 x_PM_LS_LHEN_X1%VSS_22 VSS 0.034078f
C_x_PM_LS_LHEN_X1%VSS_c13 N_VSS_M7_d VSS 0.0423476f
C_x_PM_LS_LHEN_X1%VSS_c14 x_PM_LS_LHEN_X1%VSS_17 VSS 0.0106068f
C_x_PM_LS_LHEN_X1%VSS_c15 x_PM_LS_LHEN_X1%VSS_16 VSS 0.0560111f
C_x_PM_LS_LHEN_X1%VSS_c16 x_PM_LS_LHEN_X1%VSS_13 VSS 0.706493f
C_x_PM_LS_LHEN_X1%VSS_c17 x_PM_LS_LHEN_X1%VSS_12 VSS 0.0192462f
R_x_PM_LS_LHEN_X1%VSS_r18 N_VSS_M7_b x_PM_LS_LHEN_X1%VSS_52 0.138985 
R_x_PM_LS_LHEN_X1%VSS_r19 x_PM_LS_LHEN_X1%VSS_43 x_PM_LS_LHEN_X1%VSS_57 0.0731438 
R_x_PM_LS_LHEN_X1%VSS_r20 N_VSS_M7_b x_PM_LS_LHEN_X1%VSS_42 0.13879 
R_x_PM_LS_LHEN_X1%VSS_r21 x_PM_LS_LHEN_X1%VSS_42 x_PM_LS_LHEN_X1%VSS_43 0.637059 
R_x_PM_LS_LHEN_X1%VSS_r22 x_PM_LS_LHEN_X1%VSS_38 x_PM_LS_LHEN_X1%VSS_57 0.145286 
R_x_PM_LS_LHEN_X1%VSS_r23 x_PM_LS_LHEN_X1%VSS_38 N_VSS_M14_d 0.773571 
R_x_PM_LS_LHEN_X1%VSS_r24 x_PM_LS_LHEN_X1%VSS_37 x_PM_LS_LHEN_X1%VSS_56 0.0731438 
R_x_PM_LS_LHEN_X1%VSS_r25 x_PM_LS_LHEN_X1%VSS_36 x_PM_LS_LHEN_X1%VSS_57 0.0731438 
R_x_PM_LS_LHEN_X1%VSS_r26 x_PM_LS_LHEN_X1%VSS_36 x_PM_LS_LHEN_X1%VSS_37 1.06176 
R_x_PM_LS_LHEN_X1%VSS_r27 x_PM_LS_LHEN_X1%VSS_32 x_PM_LS_LHEN_X1%VSS_56 0.145286 
R_x_PM_LS_LHEN_X1%VSS_r28 x_PM_LS_LHEN_X1%VSS_32 N_VSS_M12_d 0.909286 
R_x_PM_LS_LHEN_X1%VSS_r29 x_PM_LS_LHEN_X1%VSS_29 x_PM_LS_LHEN_X1%VSS_55 0.0731438 
R_x_PM_LS_LHEN_X1%VSS_r30 x_PM_LS_LHEN_X1%VSS_29 VSS 0.793529 
R_x_PM_LS_LHEN_X1%VSS_r31 x_PM_LS_LHEN_X1%VSS_28 x_PM_LS_LHEN_X1%VSS_56 0.0731438 
R_x_PM_LS_LHEN_X1%VSS_r32 x_PM_LS_LHEN_X1%VSS_28 VSS 1.06176 
R_x_PM_LS_LHEN_X1%VSS_r33 x_PM_LS_LHEN_X1%VSS_24 x_PM_LS_LHEN_X1%VSS_55 0.145286 
R_x_PM_LS_LHEN_X1%VSS_r34 x_PM_LS_LHEN_X1%VSS_24 N_VSS_M9_s 0.909286 
R_x_PM_LS_LHEN_X1%VSS_r35 x_PM_LS_LHEN_X1%VSS_23 x_PM_LS_LHEN_X1%VSS_54 0.0731438 
R_x_PM_LS_LHEN_X1%VSS_r36 x_PM_LS_LHEN_X1%VSS_22 x_PM_LS_LHEN_X1%VSS_55 0.0731438 
R_x_PM_LS_LHEN_X1%VSS_r37 x_PM_LS_LHEN_X1%VSS_22 x_PM_LS_LHEN_X1%VSS_23 0.637059 
R_x_PM_LS_LHEN_X1%VSS_r38 x_PM_LS_LHEN_X1%VSS_18 x_PM_LS_LHEN_X1%VSS_54 0.145286 
R_x_PM_LS_LHEN_X1%VSS_r39 x_PM_LS_LHEN_X1%VSS_18 N_VSS_M7_d 0.637857 
R_x_PM_LS_LHEN_X1%VSS_r40 N_VSS_M7_b x_PM_LS_LHEN_X1%VSS_17 0.138595 
R_x_PM_LS_LHEN_X1%VSS_r41 x_PM_LS_LHEN_X1%VSS_16 x_PM_LS_LHEN_X1%VSS_54 0.0731438 
R_x_PM_LS_LHEN_X1%VSS_r42 x_PM_LS_LHEN_X1%VSS_16 x_PM_LS_LHEN_X1%VSS_17 1.33 
R_x_PM_LS_LHEN_X1%VSS_r43 x_PM_LS_LHEN_X1%VSS_13 VSS 11.0647 
R_x_PM_LS_LHEN_X1%VSS_r44 x_PM_LS_LHEN_X1%VSS_12 N_VSS_M7_b 0.140282 
R_x_PM_LS_LHEN_X1%VSS_r45 x_PM_LS_LHEN_X1%VSS_52 x_PM_LS_LHEN_X1%VSS_12 7.68941 
C_x_PM_LS_LHEN_X1%A_c0 x_PM_LS_LHEN_X1%A_21 VSS 0.0153158f
C_x_PM_LS_LHEN_X1%A_c1 x_PM_LS_LHEN_X1%A_14 VSS 0.0591707f
C_x_PM_LS_LHEN_X1%A_c2 x_PM_LS_LHEN_X1%A_13 VSS 0.00483269f
C_x_PM_LS_LHEN_X1%A_c3 A VSS 0.0210652f
C_x_PM_LS_LHEN_X1%A_c4 N_A_M0_g VSS 0.0360182f
C_x_PM_LS_LHEN_X1%A_c5 N_A_M7_g VSS 0.0433247f
R_x_PM_LS_LHEN_X1%A_r6 x_PM_LS_LHEN_X1%A_20 x_PM_LS_LHEN_X1%A_21 3.64 
R_x_PM_LS_LHEN_X1%A_r7 x_PM_LS_LHEN_X1%A_16 x_PM_LS_LHEN_X1%A_20 2.86 
R_x_PM_LS_LHEN_X1%A_r8 x_PM_LS_LHEN_X1%A_14 x_PM_LS_LHEN_X1%A_16 25.0012 
R_x_PM_LS_LHEN_X1%A_r9 x_PM_LS_LHEN_X1%A_13 x_PM_LS_LHEN_X1%A_14 0.773571 
R_x_PM_LS_LHEN_X1%A_r10 x_PM_LS_LHEN_X1%A_9 x_PM_LS_LHEN_X1%A_13 0.212317 
R_x_PM_LS_LHEN_X1%A_r11 x_PM_LS_LHEN_X1%A_9 A 0.488571 
R_x_PM_LS_LHEN_X1%A_r12 x_PM_LS_LHEN_X1%A_5 x_PM_LS_LHEN_X1%A_21 1.95 
R_x_PM_LS_LHEN_X1%A_r13 x_PM_LS_LHEN_X1%A_5 N_A_M0_g 27.3 
R_x_PM_LS_LHEN_X1%A_r14 x_PM_LS_LHEN_X1%A_1 x_PM_LS_LHEN_X1%A_20 1.95 
R_x_PM_LS_LHEN_X1%A_r15 x_PM_LS_LHEN_X1%A_1 N_A_M7_g 39.78 
C_x_PM_LS_LHEN_X1%4_c0 x_PM_LS_LHEN_X1%4_36 VSS 0.0368741f
C_x_PM_LS_LHEN_X1%4_c1 x_PM_LS_LHEN_X1%4_34 VSS 0.0517899f
C_x_PM_LS_LHEN_X1%4_c2 x_PM_LS_LHEN_X1%4_29 VSS 0.0581305f
C_x_PM_LS_LHEN_X1%4_c3 x_PM_LS_LHEN_X1%4_28 VSS 0.0175788f
C_x_PM_LS_LHEN_X1%4_c4 x_PM_LS_LHEN_X1%4_27 VSS 0.0517025f
C_x_PM_LS_LHEN_X1%4_c5 N_4_M7_s VSS 0.0342321f
C_x_PM_LS_LHEN_X1%4_c6 x_PM_LS_LHEN_X1%4_17 VSS 0.0207569f
C_x_PM_LS_LHEN_X1%4_c7 N_4_M11_g VSS 0.0486877f
C_x_PM_LS_LHEN_X1%4_c8 x_PM_LS_LHEN_X1%4_11 VSS 0.0635209f
C_x_PM_LS_LHEN_X1%4_c9 x_PM_LS_LHEN_X1%4_10 VSS 0.00990495f
C_x_PM_LS_LHEN_X1%4_c10 x_PM_LS_LHEN_X1%4_9 VSS 0.0313736f
C_x_PM_LS_LHEN_X1%4_c11 N_4_M1_g VSS 0.0336012f
C_x_PM_LS_LHEN_X1%4_c12 N_4_M8_g VSS 0.0381778f
R_x_PM_LS_LHEN_X1%4_r13 x_PM_LS_LHEN_X1%4_43 x_PM_LS_LHEN_X1%4_44 3.64 
R_x_PM_LS_LHEN_X1%4_r14 x_PM_LS_LHEN_X1%4_41 x_PM_LS_LHEN_X1%4_43 1.82 
R_x_PM_LS_LHEN_X1%4_r15 x_PM_LS_LHEN_X1%4_36 N_4_M0_s 0.176429 
R_x_PM_LS_LHEN_X1%4_r16 x_PM_LS_LHEN_X1%4_34 x_PM_LS_LHEN_X1%4_41 25.0012 
R_x_PM_LS_LHEN_X1%4_r17 x_PM_LS_LHEN_X1%4_32 x_PM_LS_LHEN_X1%4_34 0.637857 
R_x_PM_LS_LHEN_X1%4_r18 x_PM_LS_LHEN_X1%4_31 x_PM_LS_LHEN_X1%4_34 0.447857 
R_x_PM_LS_LHEN_X1%4_r19 x_PM_LS_LHEN_X1%4_30 x_PM_LS_LHEN_X1%4_36 0.095 
R_x_PM_LS_LHEN_X1%4_r20 x_PM_LS_LHEN_X1%4_29 x_PM_LS_LHEN_X1%4_32 0.212317 
R_x_PM_LS_LHEN_X1%4_r21 x_PM_LS_LHEN_X1%4_29 x_PM_LS_LHEN_X1%4_30 0.841429 
R_x_PM_LS_LHEN_X1%4_r22 x_PM_LS_LHEN_X1%4_27 x_PM_LS_LHEN_X1%4_31 0.212317 
R_x_PM_LS_LHEN_X1%4_r23 x_PM_LS_LHEN_X1%4_27 x_PM_LS_LHEN_X1%4_28 1.03143 
R_x_PM_LS_LHEN_X1%4_r24 x_PM_LS_LHEN_X1%4_23 x_PM_LS_LHEN_X1%4_28 0.212317 
R_x_PM_LS_LHEN_X1%4_r25 x_PM_LS_LHEN_X1%4_23 N_4_M7_s 0.637857 
R_x_PM_LS_LHEN_X1%4_r26 x_PM_LS_LHEN_X1%4_17 x_PM_LS_LHEN_X1%4_19 10.92 
R_x_PM_LS_LHEN_X1%4_r27 x_PM_LS_LHEN_X1%4_13 N_4_M11_g 46.02 
R_x_PM_LS_LHEN_X1%4_r28 x_PM_LS_LHEN_X1%4_12 x_PM_LS_LHEN_X1%4_19 1.95 
R_x_PM_LS_LHEN_X1%4_r29 x_PM_LS_LHEN_X1%4_11 x_PM_LS_LHEN_X1%4_13 4.58872 
R_x_PM_LS_LHEN_X1%4_r30 x_PM_LS_LHEN_X1%4_11 x_PM_LS_LHEN_X1%4_12 49.92 
R_x_PM_LS_LHEN_X1%4_r31 x_PM_LS_LHEN_X1%4_10 x_PM_LS_LHEN_X1%4_44 2.6 
R_x_PM_LS_LHEN_X1%4_r32 x_PM_LS_LHEN_X1%4_9 x_PM_LS_LHEN_X1%4_17 1.95 
R_x_PM_LS_LHEN_X1%4_r33 x_PM_LS_LHEN_X1%4_9 x_PM_LS_LHEN_X1%4_10 24.96 
R_x_PM_LS_LHEN_X1%4_r34 x_PM_LS_LHEN_X1%4_5 x_PM_LS_LHEN_X1%4_44 1.95 
R_x_PM_LS_LHEN_X1%4_r35 x_PM_LS_LHEN_X1%4_5 N_4_M1_g 29.64 
R_x_PM_LS_LHEN_X1%4_r36 x_PM_LS_LHEN_X1%4_1 x_PM_LS_LHEN_X1%4_43 1.95 
R_x_PM_LS_LHEN_X1%4_r37 x_PM_LS_LHEN_X1%4_1 N_4_M8_g 37.44 
C_x_PM_LS_LHEN_X1%VDDL_c0 VDDL VSS 0.0605428f
C_x_PM_LS_LHEN_X1%VDDL_c1 x_PM_LS_LHEN_X1%VDDL_6 VSS 0.0487622f
R_x_PM_LS_LHEN_X1%VDDL_r2 N_VDDL_M0_b VDDL 0.20425 
R_x_PM_LS_LHEN_X1%VDDL_r3 x_PM_LS_LHEN_X1%VDDL_6 N_VDDL_M0_b 0.095 
R_x_PM_LS_LHEN_X1%VDDL_r4 N_VDDL_M0_d x_PM_LS_LHEN_X1%VDDL_6 0.347287 
C_x_PM_LS_LHEN_X1%6_c0 x_PM_LS_LHEN_X1%6_28 VSS 0.0133857f
C_x_PM_LS_LHEN_X1%6_c1 x_PM_LS_LHEN_X1%6_25 VSS 0.019214f
C_x_PM_LS_LHEN_X1%6_c2 x_PM_LS_LHEN_X1%6_23 VSS 0.047608f
C_x_PM_LS_LHEN_X1%6_c3 x_PM_LS_LHEN_X1%6_17 VSS 0.022532f
C_x_PM_LS_LHEN_X1%6_c4 x_PM_LS_LHEN_X1%6_13 VSS 0.0538994f
C_x_PM_LS_LHEN_X1%6_c5 N_6_M1_d VSS 0.0399906f
C_x_PM_LS_LHEN_X1%6_c6 x_PM_LS_LHEN_X1%6_8 VSS 0.0360895f
C_x_PM_LS_LHEN_X1%6_c7 N_6_M10_g VSS 0.024286f
R_x_PM_LS_LHEN_X1%6_r8 x_PM_LS_LHEN_X1%6_26 x_PM_LS_LHEN_X1%6_28 3.9 
R_x_PM_LS_LHEN_X1%6_r9 N_6_M8_d x_PM_LS_LHEN_X1%6_23 0.176429 
R_x_PM_LS_LHEN_X1%6_r10 x_PM_LS_LHEN_X1%6_17 x_PM_LS_LHEN_X1%6_26 25.0012 
R_x_PM_LS_LHEN_X1%6_r11 x_PM_LS_LHEN_X1%6_15 x_PM_LS_LHEN_X1%6_17 0.257857 
R_x_PM_LS_LHEN_X1%6_r12 x_PM_LS_LHEN_X1%6_14 x_PM_LS_LHEN_X1%6_25 0.0418175 
R_x_PM_LS_LHEN_X1%6_r13 x_PM_LS_LHEN_X1%6_13 x_PM_LS_LHEN_X1%6_15 0.212317 
R_x_PM_LS_LHEN_X1%6_r14 x_PM_LS_LHEN_X1%6_13 x_PM_LS_LHEN_X1%6_14 1.65571 
R_x_PM_LS_LHEN_X1%6_r15 x_PM_LS_LHEN_X1%6_9 x_PM_LS_LHEN_X1%6_25 0.160909 
R_x_PM_LS_LHEN_X1%6_r16 x_PM_LS_LHEN_X1%6_9 N_6_M1_d 0.882143 
R_x_PM_LS_LHEN_X1%6_r17 x_PM_LS_LHEN_X1%6_8 x_PM_LS_LHEN_X1%6_25 0.160909 
R_x_PM_LS_LHEN_X1%6_r18 x_PM_LS_LHEN_X1%6_7 x_PM_LS_LHEN_X1%6_23 0.095 
R_x_PM_LS_LHEN_X1%6_r19 x_PM_LS_LHEN_X1%6_7 x_PM_LS_LHEN_X1%6_8 1.11286 
R_x_PM_LS_LHEN_X1%6_r20 x_PM_LS_LHEN_X1%6_1 x_PM_LS_LHEN_X1%6_28 1.95 
R_x_PM_LS_LHEN_X1%6_r21 x_PM_LS_LHEN_X1%6_1 N_6_M10_g 14.82 
C_x_PM_LS_LHEN_X1%7_c0 x_PM_LS_LHEN_X1%7_23 VSS 0.0182621f
C_x_PM_LS_LHEN_X1%7_c1 x_PM_LS_LHEN_X1%7_20 VSS 0.0058493f
C_x_PM_LS_LHEN_X1%7_c2 x_PM_LS_LHEN_X1%7_16 VSS 0.0463213f
C_x_PM_LS_LHEN_X1%7_c3 N_7_M2_s VSS 0.0614608f
C_x_PM_LS_LHEN_X1%7_c4 N_7_M10_d VSS 0.118232f
C_x_PM_LS_LHEN_X1%7_c5 N_7_M3_g VSS 0.0532827f
R_x_PM_LS_LHEN_X1%7_r6 x_PM_LS_LHEN_X1%7_18 x_PM_LS_LHEN_X1%7_23 7.02 
R_x_PM_LS_LHEN_X1%7_r7 x_PM_LS_LHEN_X1%7_16 x_PM_LS_LHEN_X1%7_18 25.0012 
R_x_PM_LS_LHEN_X1%7_r8 x_PM_LS_LHEN_X1%7_15 x_PM_LS_LHEN_X1%7_20 0.0418175 
R_x_PM_LS_LHEN_X1%7_r9 x_PM_LS_LHEN_X1%7_15 x_PM_LS_LHEN_X1%7_16 0.773571 
R_x_PM_LS_LHEN_X1%7_r10 x_PM_LS_LHEN_X1%7_11 x_PM_LS_LHEN_X1%7_20 0.160909 
R_x_PM_LS_LHEN_X1%7_r11 x_PM_LS_LHEN_X1%7_7 x_PM_LS_LHEN_X1%7_20 0.160909 
R_x_PM_LS_LHEN_X1%7_r12 x_PM_LS_LHEN_X1%7_7 N_7_M2_s 1.72357 
R_x_PM_LS_LHEN_X1%7_r13 x_PM_LS_LHEN_X1%7_11 N_7_M10_d 2.83643 
R_x_PM_LS_LHEN_X1%7_r14 x_PM_LS_LHEN_X1%7_1 x_PM_LS_LHEN_X1%7_23 1.95 
R_x_PM_LS_LHEN_X1%7_r15 x_PM_LS_LHEN_X1%7_1 N_7_M3_g 53.43 
C_x_PM_LS_LHEN_X1%8_c0 x_PM_LS_LHEN_X1%8_42 VSS 0.0107471f
C_x_PM_LS_LHEN_X1%8_c1 x_PM_LS_LHEN_X1%8_35 VSS 0.00577163f
C_x_PM_LS_LHEN_X1%8_c2 x_PM_LS_LHEN_X1%8_32 VSS 0.125784f
C_x_PM_LS_LHEN_X1%8_c3 N_8_M3_d VSS 0.0308929f
C_x_PM_LS_LHEN_X1%8_c4 x_PM_LS_LHEN_X1%8_25 VSS 0.0342081f
C_x_PM_LS_LHEN_X1%8_c5 x_PM_LS_LHEN_X1%8_23 VSS 0.0212189f
C_x_PM_LS_LHEN_X1%8_c6 x_PM_LS_LHEN_X1%8_22 VSS 0.011687f
C_x_PM_LS_LHEN_X1%8_c7 N_8_M11_s VSS 0.0638981f
C_x_PM_LS_LHEN_X1%8_c8 x_PM_LS_LHEN_X1%8_17 VSS 0.0842411f
C_x_PM_LS_LHEN_X1%8_c9 x_PM_LS_LHEN_X1%8_16 VSS 0.0162587f
C_x_PM_LS_LHEN_X1%8_c10 N_8_M5_g VSS 0.0706531f
C_x_PM_LS_LHEN_X1%8_c11 N_8_M14_g VSS 0.0404816f
C_x_PM_LS_LHEN_X1%8_c12 N_8_M2_g VSS 0.0341148f
R_x_PM_LS_LHEN_X1%8_r13 x_PM_LS_LHEN_X1%8_40 x_PM_LS_LHEN_X1%8_42 3.38 
R_x_PM_LS_LHEN_X1%8_r14 x_PM_LS_LHEN_X1%8_32 x_PM_LS_LHEN_X1%8_40 25.0012 
R_x_PM_LS_LHEN_X1%8_r15 x_PM_LS_LHEN_X1%8_30 x_PM_LS_LHEN_X1%8_32 3.16214 
R_x_PM_LS_LHEN_X1%8_r16 x_PM_LS_LHEN_X1%8_26 x_PM_LS_LHEN_X1%8_35 0.266978 
R_x_PM_LS_LHEN_X1%8_r17 x_PM_LS_LHEN_X1%8_26 N_8_M3_d 0.583571 
R_x_PM_LS_LHEN_X1%8_r18 x_PM_LS_LHEN_X1%8_25 x_PM_LS_LHEN_X1%8_35 0.266978 
R_x_PM_LS_LHEN_X1%8_r19 x_PM_LS_LHEN_X1%8_24 x_PM_LS_LHEN_X1%8_30 0.095 
R_x_PM_LS_LHEN_X1%8_r20 x_PM_LS_LHEN_X1%8_24 x_PM_LS_LHEN_X1%8_25 1.87286 
R_x_PM_LS_LHEN_X1%8_r21 x_PM_LS_LHEN_X1%8_22 x_PM_LS_LHEN_X1%8_30 0.19 
R_x_PM_LS_LHEN_X1%8_r22 x_PM_LS_LHEN_X1%8_22 x_PM_LS_LHEN_X1%8_23 0.732857 
R_x_PM_LS_LHEN_X1%8_r23 x_PM_LS_LHEN_X1%8_18 x_PM_LS_LHEN_X1%8_23 0.212317 
R_x_PM_LS_LHEN_X1%8_r24 x_PM_LS_LHEN_X1%8_18 N_8_M11_s 1.37071 
R_x_PM_LS_LHEN_X1%8_r25 x_PM_LS_LHEN_X1%8_17 x_PM_LS_LHEN_X1%8_35 0.0272847 
R_x_PM_LS_LHEN_X1%8_r26 x_PM_LS_LHEN_X1%8_36 x_PM_LS_LHEN_X1%8_16 4.42 
R_x_PM_LS_LHEN_X1%8_r27 x_PM_LS_LHEN_X1%8_15 x_PM_LS_LHEN_X1%8_17 0.572472 
R_x_PM_LS_LHEN_X1%8_r28 x_PM_LS_LHEN_X1%8_15 x_PM_LS_LHEN_X1%8_16 25.0012 
R_x_PM_LS_LHEN_X1%8_r29 x_PM_LS_LHEN_X1%8_9 x_PM_LS_LHEN_X1%8_42 1.95 
R_x_PM_LS_LHEN_X1%8_r30 x_PM_LS_LHEN_X1%8_9 N_8_M5_g 79.56 
R_x_PM_LS_LHEN_X1%8_r31 x_PM_LS_LHEN_X1%8_5 x_PM_LS_LHEN_X1%8_42 1.95 
R_x_PM_LS_LHEN_X1%8_r32 x_PM_LS_LHEN_X1%8_5 N_8_M14_g 37.44 
R_x_PM_LS_LHEN_X1%8_r33 x_PM_LS_LHEN_X1%8_1 x_PM_LS_LHEN_X1%8_36 1.95 
R_x_PM_LS_LHEN_X1%8_r34 x_PM_LS_LHEN_X1%8_1 N_8_M2_g 26.13 
C_x_PM_LS_LHEN_X1%ISOLN_c0 x_PM_LS_LHEN_X1%ISOLN_22 VSS 0.0451198f
C_x_PM_LS_LHEN_X1%ISOLN_c1 x_PM_LS_LHEN_X1%ISOLN_21 VSS 0.00530293f
C_x_PM_LS_LHEN_X1%ISOLN_c2 x_PM_LS_LHEN_X1%ISOLN_20 VSS 0.0282658f
C_x_PM_LS_LHEN_X1%ISOLN_c3 x_PM_LS_LHEN_X1%ISOLN_19 VSS 0.0104125f
C_x_PM_LS_LHEN_X1%ISOLN_c4 N_ISOLN_M4_g VSS 0.054906f
C_x_PM_LS_LHEN_X1%ISOLN_c5 N_ISOLN_M13_g VSS 0.0618516f
C_x_PM_LS_LHEN_X1%ISOLN_c6 N_ISOLN_M12_g VSS 0.0599111f
C_x_PM_LS_LHEN_X1%ISOLN_c7 x_PM_LS_LHEN_X1%ISOLN_6 VSS 0.00559264f
C_x_PM_LS_LHEN_X1%ISOLN_c8 x_PM_LS_LHEN_X1%ISOLN_5 VSS 0.0924516f
C_x_PM_LS_LHEN_X1%ISOLN_c9 N_ISOLN_M9_g VSS 0.032659f
R_x_PM_LS_LHEN_X1%ISOLN_r10 x_PM_LS_LHEN_X1%ISOLN_22 x_PM_LS_LHEN_X1%ISOLN_24 25.0012 
R_x_PM_LS_LHEN_X1%ISOLN_r11 x_PM_LS_LHEN_X1%ISOLN_22 ISOLN 0.26037 
R_x_PM_LS_LHEN_X1%ISOLN_r12 x_PM_LS_LHEN_X1%ISOLN_20 x_PM_LS_LHEN_X1%ISOLN_24 9.75 
R_x_PM_LS_LHEN_X1%ISOLN_r13 x_PM_LS_LHEN_X1%ISOLN_20 x_PM_LS_LHEN_X1%ISOLN_21 0.422157 
R_x_PM_LS_LHEN_X1%ISOLN_r14 x_PM_LS_LHEN_X1%ISOLN_19 x_PM_LS_LHEN_X1%ISOLN_24 16.25 
R_x_PM_LS_LHEN_X1%ISOLN_r15 x_PM_LS_LHEN_X1%ISOLN_15 x_PM_LS_LHEN_X1%ISOLN_21 5.21812 
R_x_PM_LS_LHEN_X1%ISOLN_r16 x_PM_LS_LHEN_X1%ISOLN_15 N_ISOLN_M4_g 56.16 
R_x_PM_LS_LHEN_X1%ISOLN_r17 x_PM_LS_LHEN_X1%ISOLN_11 x_PM_LS_LHEN_X1%ISOLN_21 5.21812 
R_x_PM_LS_LHEN_X1%ISOLN_r18 x_PM_LS_LHEN_X1%ISOLN_11 N_ISOLN_M13_g 58.5 
R_x_PM_LS_LHEN_X1%ISOLN_r19 x_PM_LS_LHEN_X1%ISOLN_8 x_PM_LS_LHEN_X1%ISOLN_19 4.83753 
R_x_PM_LS_LHEN_X1%ISOLN_r20 x_PM_LS_LHEN_X1%ISOLN_8 N_ISOLN_M12_g 58.5 
R_x_PM_LS_LHEN_X1%ISOLN_r21 x_PM_LS_LHEN_X1%ISOLN_7 N_ISOLN_M12_g 26.52 
R_x_PM_LS_LHEN_X1%ISOLN_r22 x_PM_LS_LHEN_X1%ISOLN_5 x_PM_LS_LHEN_X1%ISOLN_7 4.35808 
R_x_PM_LS_LHEN_X1%ISOLN_r23 x_PM_LS_LHEN_X1%ISOLN_5 x_PM_LS_LHEN_X1%ISOLN_6 104.52 
R_x_PM_LS_LHEN_X1%ISOLN_r24 x_PM_LS_LHEN_X1%ISOLN_1 x_PM_LS_LHEN_X1%ISOLN_6 4.35808 
R_x_PM_LS_LHEN_X1%ISOLN_r25 x_PM_LS_LHEN_X1%ISOLN_1 N_ISOLN_M9_g 26.52 
C_x_PM_LS_LHEN_X1%10_c0 x_PM_LS_LHEN_X1%10_28 VSS 0.013937f
C_x_PM_LS_LHEN_X1%10_c1 x_PM_LS_LHEN_X1%10_24 VSS 0.114652f
C_x_PM_LS_LHEN_X1%10_c2 x_PM_LS_LHEN_X1%10_20 VSS 0.00635666f
C_x_PM_LS_LHEN_X1%10_c3 x_PM_LS_LHEN_X1%10_19 VSS 0.0484281f
C_x_PM_LS_LHEN_X1%10_c4 N_10_M4_d VSS 0.0361188f
C_x_PM_LS_LHEN_X1%10_c5 x_PM_LS_LHEN_X1%10_14 VSS 0.0175541f
C_x_PM_LS_LHEN_X1%10_c6 x_PM_LS_LHEN_X1%10_13 VSS 0.0927782f
C_x_PM_LS_LHEN_X1%10_c7 x_PM_LS_LHEN_X1%10_12 VSS 0.0402081f
C_x_PM_LS_LHEN_X1%10_c8 N_10_M6_g VSS 0.0573836f
C_x_PM_LS_LHEN_X1%10_c9 N_10_M15_g VSS 0.0598877f
R_x_PM_LS_LHEN_X1%10_r10 x_PM_LS_LHEN_X1%10_26 x_PM_LS_LHEN_X1%10_28 5.46 
R_x_PM_LS_LHEN_X1%10_r11 x_PM_LS_LHEN_X1%10_24 x_PM_LS_LHEN_X1%10_26 25.0012 
R_x_PM_LS_LHEN_X1%10_r12 x_PM_LS_LHEN_X1%10_22 x_PM_LS_LHEN_X1%10_24 1.28929 
R_x_PM_LS_LHEN_X1%10_r13 x_PM_LS_LHEN_X1%10_21 x_PM_LS_LHEN_X1%10_24 1.425 
R_x_PM_LS_LHEN_X1%10_r14 x_PM_LS_LHEN_X1%10_19 x_PM_LS_LHEN_X1%10_22 0.212317 
R_x_PM_LS_LHEN_X1%10_r15 x_PM_LS_LHEN_X1%10_19 x_PM_LS_LHEN_X1%10_20 0.868571 
R_x_PM_LS_LHEN_X1%10_r16 x_PM_LS_LHEN_X1%10_15 x_PM_LS_LHEN_X1%10_20 0.212317 
R_x_PM_LS_LHEN_X1%10_r17 x_PM_LS_LHEN_X1%10_15 N_10_M4_d 0.637857 
R_x_PM_LS_LHEN_X1%10_r18 x_PM_LS_LHEN_X1%10_13 x_PM_LS_LHEN_X1%10_21 0.212317 
R_x_PM_LS_LHEN_X1%10_r19 x_PM_LS_LHEN_X1%10_13 x_PM_LS_LHEN_X1%10_14 1.87286 
R_x_PM_LS_LHEN_X1%10_r20 x_PM_LS_LHEN_X1%10_12 x_PM_LS_LHEN_X1%10_14 0.212317 
R_x_PM_LS_LHEN_X1%10_r21 N_10_M13_s x_PM_LS_LHEN_X1%10_12 0.570339 
R_x_PM_LS_LHEN_X1%10_r22 x_PM_LS_LHEN_X1%10_5 x_PM_LS_LHEN_X1%10_28 1.95 
R_x_PM_LS_LHEN_X1%10_r23 x_PM_LS_LHEN_X1%10_5 N_10_M6_g 54.6 
R_x_PM_LS_LHEN_X1%10_r24 x_PM_LS_LHEN_X1%10_1 x_PM_LS_LHEN_X1%10_28 1.95 
R_x_PM_LS_LHEN_X1%10_r25 x_PM_LS_LHEN_X1%10_1 N_10_M15_g 66.3 
C_x_PM_LS_LHEN_X1%Z_c0 N_Z_M15_d VSS 0.190614f
R_x_PM_LS_LHEN_X1%Z_r1 Z N_Z_M6_d 2.49533 
R_x_PM_LS_LHEN_X1%Z_r2 N_Z_M15_d Z 2.03933 
.ENDS

********************************************************************************
*
* END
*
********************************************************************************
