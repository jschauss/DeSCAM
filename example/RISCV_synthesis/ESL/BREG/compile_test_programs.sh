#!/bin/bash
START_ADDRESS="0x0"

OUTPUT_DIR=${SCAM_HOME}/example/RISCV_synthesis/ESL/BREG/test_programs
mkdir -p ${OUTPUT_DIR}

echo -e "\e[30;48;5;82mCompilation of programs started\e[0m"
for filepath in ${SCAM_HOME}/example/RISCV_Test_ELF/Instruction_Tests/*.S ${SCAM_HOME}/example/RISCV_Test_ELF/Programs/*.S
do
	filename=${filepath##*/}
	filenamenoext=${filename%.S}
	if !(riscv32-unknown-elf-gcc "$filepath" -o "$OUTPUT_DIR/${filenamenoext}.elf" -Ttext $START_ADDRESS -O0 -march=rv32i -mabi=ilp32 -nostartfiles &&
		riscv32-unknown-elf-objdump -S "$OUTPUT_DIR/${filenamenoext}.elf" > "$OUTPUT_DIR/${filenamenoext}.asm") then
 		echo -e "\e[41mError while compiling:\e[0m\n"$filename"\n"
		break
	fi
	printf "${filenamenoext}.elf and ${filenamenoext}.asm created.\n"
done

for filepath in ${SCAM_HOME}/example/RISCV_Test_ELF/Programs/*_c/*.cpp
do
	filename=${filepath##*/}
	filenamenoext=${filename%.cpp}
	filedir=${filepath%/*}
	if !(riscv32-unknown-elf-gcc $filedir/bootstrap.S "$filepath" -o "$OUTPUT_DIR/${filenamenoext}.elf" -Ttext $START_ADDRESS -O0 -march=rv32i -mabi=ilp32 -nostartfiles &&
		riscv32-unknown-elf-objdump -S "$OUTPUT_DIR/${filenamenoext}.elf" > "$OUTPUT_DIR/${filenamenoext}.asm") then
 		echo -e "\e[41mError while compiling:\e[0m\n"$filename"\n"
		break
	fi
	printf "${filenamenoext}.elf and ${filenamenoext}.asm created.\n"
done

echo -e "\e[30;48;5;82mCompilation of programs finished\n\e[0m"
