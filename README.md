# montadorRISCV
Montador de instruções para o processador RISC-V
## Modo de usar
1 - instructions.txt deve conter cada instrução em assembly para ser convertida, uma em cada linha do arquivo.
2 - Após executar "run", instructions.mif conterá as instruções montadas
3 - Nada disso funcionará perfeitamente pois nada funciona perfeitamente, há braços.

## Status do desenvolvimento
### Instruções Implementadas

#### Tipo R
- [x] add
- [x] sub
- [x] sll
- [x] xor
- [x] srl
- [ ] slt
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
- [ ] slti
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
- [ ] slt
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
- [ ] slli
- [ ] srli
- [ ] slti
- [ ] srai
- [ ] xori
- [ ] ori
- [ ] andi
- [ ] jalr

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
- [ ] lui

#### Tipo UJ
- [ ] jal
