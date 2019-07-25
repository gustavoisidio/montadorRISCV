
# Assembler for RISC-V instructions
![[RISC-V](https://http://riscv.org/)](outros/image8.png)

### Download
* [MacOS]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.3/runableMACOS.zip ) 

### Instructions (macOS)
1. Unpack runableMACOS.
2. Run "run.command" to create instructions instructions.txt and instructions.mif
3. Add your assembly code in instructions.txt run "run.command" and the translation will be inside of instructions.mif.

* [Windows]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.3/runableWINDOWS.zip ) 

### Instructions (Windows)
1. Unpack runableWINDOWS.
2. Add your assembly code in instructions.txt and double click in "run.exe". The translation will be inside of instructions.mif.


#### Instructions tested and working
Those unchecked have never been tested and those with "-" are not working as expected

#### R-Type
- [x] add
- [x] sub
- [ ] sll
- [ ] xor
- [ ] srl
- [x] slt
- [ ] sra
- [ ] or
- [x] and

#### I-Type
- [x] lb
- [x] lh
- [x] lw
- [x] ld
- [x] lbu
- [x] lhu
- [x] lwu
- [x] addi
- [-] slli
- [-] srli
- [x] slti
- [-] srai
- [ ] xori
- [ ] ori
- [ ] andi
- [x] jalr

#### S-Type
- [x] sb
- [x] sh
- [x] sw
- [x] sd

#### SB-Type
- [x] bne
- [x] blt
- [x] beq
- [x] bge
- [ ] bltu
- [ ] bgeu

#### U-Type
- [x] lui

#### UJ-Type
- [x] jal
