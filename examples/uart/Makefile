default:
	gprbuild
	objcopy -O ihex bin/program.elf bin/program.hex
	arm-eabi-objdump -D bin/program.elf > bin/disassembly.txt

clean:
	- gprclean
	- rm bin/program.hex
	- rm bin/disassembly.txt