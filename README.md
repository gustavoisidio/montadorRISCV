
# Assembler for RISC-V instructions
![[RISC-V](https://http://riscv.org/)](outros/image8.png)

## Downloading & Usage
If you wanna compile by yourself, go to "montador" folder. There you gonna find a haskell file named "source.hs". With ghc installed, you need to run `ghc -o source source.hs` and add manualy instructions.txt and instructions.mif if those files waren't there yet. After that you just add your assembly code in instructions.txt and double click in the source executable to see the magic that will appear inside of instructions.mif. Otherwise you can just download the latest [windows](https://github.com/gustavoisidio/montadorRISCV/releases/download/0.3/runableWINDOWS.zip), [Linux](https://github.com/gustavoisidio/montadorRISCV/releases/download/0.4/runableLINUX.zip) or [macOS]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.3/runableMACOS.zip ) version and folow the instructions below.

### Windows [version 0.4]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.4/runableWINDOWS.zip )
* Unpack runableWINDOWS.
* Add your assembly code in instructions.txt and double click in "run.exe". The translation will be inside of instructions.mif.

### macOS [version 0.4]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.4/runableMACOS.zip ) 
* Unpack runableMACOS.
* Run "run.command" to create instructions instructions.txt and instructions.mif
* Add your assembly code in instructions.txt run "run.command" and the translation will be inside of instructions.mif.

### Linux [version 0.4]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.4/runableLINUX.zip )
* Unpack runableLINUX.
* Add your assembly code in instructions.txt and double click in "run.exe". The translation will be inside of instructions.mif.

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
