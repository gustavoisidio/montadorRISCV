
# Montador de instruções para o processador RISC-V
![[RISC-V](https://http://riscv.org/)](outros/image8.png)

### Download
* [MacOS]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.3/runableMACOS.zip ) 

### Instruções (macOS)
1. Descompactar a pasta runableMACOS.
2. Executar o script "run.command" para criar os arquivos instructions.txt e instructions.mif
3. Preencher instructions.txt com as instruções desejadas e executar mais uma vez o script "run.command" para que a tradução seja feita.

* [Windows]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.3/runableWINDOWS.zip ) 

### Instruções (Windows)
1. Descompactar a pasta runableWINDOWS.
2. Preencher instructions.txt com as instruções desejadas e executar "run.exe" tradução seja feita para o arquivo instructions.mif.


#### Instruções funcionando

#### Tipo R
- [x] add
- [x] sub
- [ ] sll
- [ ] xor
- [ ] srl
- [x] slt
- [ ] sra
- [ ] or
- [x] and

#### Tipo I
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

#### Tipo S
- [x] sb
- [x] sh
- [x] sw
- [x] sd

#### Tipo SB
- [x] bne
- [x] blt
- [x] beq
- [x] bge
- [ ] bltu
- [ ] bgeu

#### Tipo U
- [x] lui

#### Tipo UJ
- [x] jal
