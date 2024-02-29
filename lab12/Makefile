cc = clang-15
flags = --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax

prog.x: a.o 
	ld.lld a.o -o prog.x
a.o: a.s
	$(cc) $(flags)  a.s -c -o a.o

dump: prog.x
	llvm-objdump -D prog.x
