# montadorRISCV
Montador de instruções para o processador RISC-V
## Modo de usar
1. Os arquivos úteis para execução encontram-se na pasta /montador
2. Dentro da pasta /montador, o arquivo instructions.txt deve conter cada instrução em assembly para ser convertida, uma em cada linha do arquivo.
3. Após executar ./exec dentro da pasta /montador, instructions.mif conterá as instruções montadas
4. Nada disso funcionará perfeitamente pois nada funciona perfeitamente, há braços.
5. Baixando uma das versões abaixo, basta descompactar e executar o script "run"

## Versão 0.1
* [MacOS]( https://github.com/gustavoisidio/montadorRISCV/releases/download/0.1/0.1.zip ) 

## Status do desenvolvimento
### Instruções Implementadas

#### Tipo R
- [x] add
- [x] sub
- [x] sll
- [x] xor
- [x] srl
- [x] slt
- [x] sra
- [x] or
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
- [x] slli
- [x] slti
- [x] srli
- [x] srai
- [x] xori
- [x] ori
- [x] andi
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
- [x] bltu
- [x] bgeu

#### Tipo U
- [x] lui

#### Tipo UJ
- [x] jal

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
