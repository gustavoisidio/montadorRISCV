# montadorRISCV
Montador de instruções para o processador RISC-V

## Modo de usar macOS
1. Descompactar a pasta runableMACOS.
2. Executar o script "run.command" para criar os arquivos instructions.txt e instructions.mif
3. Preencher instructions.txt com as instruções desejadas e executar mais uma vez o script "run.command" para que a tradução seja feita.

## Versão 0.1
* [MacOS]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.2/runableMACOS.zip ) 

### Instruções Testadas e Funcionando

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
