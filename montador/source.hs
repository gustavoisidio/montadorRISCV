import Numeric (showHex, showIntAtBase)
--import Data.Char (intToDigit)
import System.IO
import Data.Char
import System.Directory

--widthFile = 0 :: Int
--depthFile = 0 :: Int 

main = do
    exedir <- getCurrentDirectory
    contents <- readFile (exedir ++ "/instructions.txt")
    writeFile (exedir ++ "/instructions.mif") ( unlines (headerFile ( lines contents ) ( -1 ) ( length ( lines contents ) ) ) )
    --writeFile (exedir ++ "/instructions.mif") ( unlines (fillWithZeros 12 ) ) 
     
 -- putStr $ show ( length ( lines contents ) )
    -- putStr $ show exedir
--    widthFile = ( length ( lines contents ) ) :: Int  
--putStr ( unlines (programControll ( lines contents ) 0 ) )
--    writeFile "intructions.mif" ( map ( \x -> case x of ',' ->  ' '; ')' -> ' '; '(' -> ' '; _ -> x) contents)

-- Deixa maiuscula a primeira letra de cada linha
jtoUpper :: [ String ] -> [ String ]
jtoUpper [  ] = [  ]
jtoUpper ( a : [  ] ) = ( ( toUpper ( head a ) ) : ( tail a ) ) : [  ]
jtoUpper ( a:as ) = ( ( toUpper ( head a ) ) : ( tail a ) )  : ( jtoUpper as )

-- Gambiarra pra conectar 'main' com instDecod
runAllInst :: [ String ] -> [ String ]
runAllInst x = map instDecod x

-- Converte inteiro em binario
intToBin :: String -> String 
intToBin x = showIntAtBase 2 intToDigit ( read x ) "" 

-- Arredonda numeros binarios ate count bits acrescentando 0's a esquerda 
roundBin :: Int -> String -> String
roundBin count bin = ( drop (( length fatbin ) - ( length bin ) - ( count - ( length bin ) )) fatbin)
     where fatbin = "000000000000000000000000" ++ bin

-- String de teste
rtst = "add x5,x3,x0" :: String
itst = "ld x3,8(x0)" :: String

headerFile :: [ String ] -> Int -> Int -> [ String ]
headerFile instructions index width = header : ( programControll instructions index width ) 
    where header = ( "WIDTH = 8;\n"  
                  ++ "DEPTH = 256;\n\n"                 
                  ++ "ADDRESS_RADIX = DEC;\n"
                  ++ "DATA_RADIX = BIN;\n\n"
                  ++ "CONTENT\n\n"
                  ++ "BEGIN"
                   )

programControll :: [ String ] -> Int -> Int -> [ String ]
programControll [  ] index _ = fillWithZeros index  
programControll ( firstLine : otherLines ) index width | ( ( width * 4 ) + 1 ) == index = fillWithZeros index
                                                       | otherwise = ( "\n" ++ instrTitle ++ "\n\n"
                                                                    ++ instructionBinary1 ++ ";\n"
                                                                    ++ instructionBinary2 ++ ";\n"
                                                                    ++ instructionBinary3 ++ ";\n"
                                                                    ++ instructionBinary4 ++ ";") 
                                                                     : ( programControll otherLines ( index + 4 ) width )
      where instrTitle = ( "--" ++ firstLine )
            instructionBinary = instDecod firstLine
            blockIndex1 = reverse . take 3 $ reverse $ "00" ++ show ( index + 1 )
            instructionBlock1 = reverse ( take 8 instructionBinary )
            instructionBinary1 = blockIndex1 ++ ": " ++ take 8 instructionBlock1 
            blockIndex2 = reverse . take 3 $ reverse $ "00" ++ show ( index + 2 )
            instructionBlock2 = reverse ( take 8 $ drop 8 instructionBinary )
            instructionBinary2 = blockIndex2 ++ ": " ++ take 8 instructionBlock2 
            blockIndex3 = reverse . take 3 $ reverse $ "00" ++ show ( index + 3 )
            instructionBlock3 = reverse ( take 8 $ drop 16 instructionBinary )
            instructionBinary3 = blockIndex3 ++ ": " ++ take 8 instructionBlock3 
            blockIndex4 = reverse . take 3 $ reverse $ "00" ++ show ( index + 4 )
            instructionBlock4 = reverse ( take 8 $ drop 24 instructionBinary )
            instructionBinary4 = blockIndex4 ++ ": " ++ take 8 instructionBlock4 

-- Preenche com zeros quando as instrucoes acabam
fillWithZeros :: Int -> [ String ]
fillWithZeros index | index >= 255 = "END;" : [  ]
                    | otherwise = ( line1 ++ line2 ++ line3 ++ line4) : ( fillWithZeros ( index + 4 ) )
    where line1 = "\n" ++ ( roundBin 3 $ show ( index + 1 ) ) ++ ": " ++ "00000000;"
          line2 = "\n" ++ ( roundBin 3 $ show ( index + 2 ) ) ++ ": " ++ "00000000;"
          line3 = "\n" ++ ( roundBin 3 $ show ( index + 3 ) ) ++ ": " ++ "00000000;"
          line4 = "\n" ++ ( roundBin 3 $ show ( index + 4 ) ) ++ ": " ++ "00000000;"


-- Recebe uma instrucao e decodifica qual instrucao se trata
instDecod :: String -> String
instDecod x = case ( head instCleaned ) of
                
                -- Instrucoes do tipo R
                "add"  -> instAdd x rs1 rs2 rd opcodeR
                "sub"  -> instSub x rs1 rs2 rd opcodeR
                "slt"  -> instSlt x rs1 rs2 rd opcodeR
                "sll"  -> instSll x rs1 rs2 rd opcodeR
                "xor"  -> instXor x rs1 rs2 rd opcodeR
                "srl"  -> instSrl x rs1 rs2 rd opcodeR
                "sra"  -> instSra x rs1 rs2 rd opcodeR
                "or"   -> instOr x rs1 rs2 rd opcodeR
                "and"  -> instAnd x rs1 rs2 rd opcodeR
                
                -- Instrucoes do tipo I
                "lb"   -> instLb x immI rs1I rd opcodeI1
                "lh"   -> instLh x immI rs1I rd opcodeI1
                "lw"   -> instLw x immI rs1I rd opcodeI1
                "ld"   -> instLd x immI rs1I rd opcodeI1
                "lbu"  -> instLbu x immI rs1I rd opcodeI1
                "lhu"  -> instLhu x immI rs1I rd opcodeI1
                "lwu"  -> instLwu x immI rs1I rd opcodeI1
                "addi" -> instAddi x rs1 rd immI2 opcodeI2
                "slli" -> instSlli x rs1 rd immI2 opcodeI2
                "slti" -> instSlti x rs1 rd immI2 opcodeI2
                "xori" -> instXori x immI rs1I rd opcodeI2
                "srli" -> instSrli x immI rs1I rd opcodeI2
                "srai" -> instSrai x immI rs1I rd opcodeI2
                "ori"  -> instOri x immI rs1I rd opcodeI2
                "andi" -> instAndi x immI rs1I rd opcodeI2
                "jalr" -> instJalr x immI2 rs1 rd opcodeI3
                
                -- Nas instrucoes S, o rs2 toma o lugar do rd nas instrucoes do tipo R
                -- Como o rs2 eh encontrado da mesma forma do rd nas instrucoes r, 
                -- No lugar do rs2, sera posto rd por praticidade, já que já o temos.
                -- Da mesma forma, como o Imm aparece na instrucao no mesmo local do ImmI,
                -- Ele também sera reaproveitado por hora                
                "sb"   -> instSb x immI rd rs1I opcodeS 
                "sh"   -> instSh x immI rd rs1I opcodeS
                "sw"   -> instSw x immI rd rs1I opcodeS
                "sd"   -> instSd x immI rd rs1I opcodeS
                
                -- Instrucoes do tipo SB
                -- Nesse caso, a instrucao aparece de forma semelhante as de tipo R
                -- o rs1 da SB eh o rd da R
                -- o rs2 da SB eh o rs1 da R
                -- portanto, podemos aproveitar 
                "beq"  -> instBeq x immSB rd rs1 opcodeSB
                "bne"  -> instBne x immSB rd rs1 opcodeSB2
                "blt"  -> instBlt x immSB rd rs1 opcodeSB2
                "bge"  -> instBge x immSB rd rs1 opcodeSB2
                "bltu" -> instBltu x immSB rd rs1 opcodeSB
                "bgeu" -> instBgeu x immSB rd rs1 opcodeSB

                -- Instrucoes do tipo U
                "lui"  -> instLui x immU rd opcodeU
                
                -- Instrucoes do tipo UJ
                -- O immm da UJ aparece no mesmo local da U, entao usaremos reusamos ele 
                "jal"  -> instJal x immU rd opcodeUJ
                
                "break" -> instBreak x
                "nop"  -> instNop x
                _      -> "Instrucao nao identificada"

    where instCleaned = words $ map ( \x -> case x of ',' ->  ' '; ')' -> ' '; '(' -> ' '; _ -> x) x
          rs1 = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 2 )
          rs2 = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 3 )
          rd = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 1 )
          immI = roundBin 12 ( intToBin $ instCleaned !! 2 )
          immI2 = roundBin 12 ( intToBin $ instCleaned !! 3 )
          immSB = roundBin 12 ( intToBin $ instCleaned !! 3 )
          immU = roundBin 20 ( intToBin $ instCleaned !! 2)
          rs1I = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 3 )
          opcodeR = "0110011"
          opcodeI1 = "0000011"
          opcodeI2 = "0010011"
          opcodeI3 = "1100111"
          opcodeS = "0100011"
          opcodeSB = "1100011"
          opcodeSB2 = opcodeI3
          opcodeU = "0110111"
          opcodeUJ = "1101111"

-- Trata a instrucao add
instAdd :: String -> String -> String -> String -> String -> String
instAdd x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode ) 
    where funct3 = "000"
          funct7 = "0000000"

-- Trata a instrucao sub
instSub :: String -> String -> String -> String -> String -> String
instSub x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "000"
          funct7 = "0100000"

-- Trata a instrucao slt
instSlt :: String -> String -> String -> String -> String -> String
instSlt x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "010"
          funct7 = "0000000"

-- Trata a instrucao sll
instSll :: String -> String -> String -> String -> String -> String
instSll x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "001"
          funct7 = "0000000"
          
-- Trata a instrucao xor
instXor :: String -> String -> String -> String -> String -> String
instXor x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "100"
          funct7 = "0000000"

-- Trata a instrucao srl
instSrl :: String -> String -> String -> String -> String -> String
instSrl x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "101"
          funct7 = "0000000"

instSra :: String -> String -> String -> String -> String -> String
instSra x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "101"
          funct7 = "0000000"

instOr :: String -> String -> String -> String -> String -> String
instOr x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "110"
          funct7 = "0000000"

instAnd :: String -> String -> String -> String -> String -> String
instAnd x rs1 rs2 rd opcode = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "111"
          funct7 = "0000000"



-- Instrucoes do tipo I

instLd :: String -> String -> String -> String -> String -> String
instLd x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "011"

instLb :: String -> String -> String -> String -> String -> String
instLb x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "000"

instLh :: String -> String -> String -> String -> String -> String
instLh x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "001"

instLw :: String -> String -> String -> String -> String -> String
instLw x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "010"

instLbu :: String -> String -> String -> String -> String -> String
instLbu x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "100"

instLhu :: String -> String -> String -> String -> String -> String
instLhu x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "101"

instLwu :: String -> String -> String -> String -> String -> String
instLwu x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "110"

instAddi :: String -> String -> String -> String -> String -> String
instAddi x rs1 rd immI opcode = reverse ( immI ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "000"

instSlti :: String -> String -> String -> String -> String -> String
instSlti x rs1 rd immI opcode = reverse ( immI ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "010"

instSlli :: String -> String -> String -> String -> String -> String
instSlli x rs1 rd immI opcode = reverse ( immI ++ rs1 ++ funct3 ++ rd ++ opcode )
    where funct3 = "001"

instXori :: String -> String -> String -> String -> String -> String
instXori x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "100"

instSrli :: String -> String -> String -> String -> String -> String
instSrli x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "101"

instSrai :: String -> String -> String -> String -> String -> String
instSrai x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "101"

instOri :: String -> String -> String -> String -> String -> String
instOri x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "110"

instAndi :: String -> String -> String -> String -> String -> String
instAndi x immI rs1I rd opcode = reverse ( immI ++ rs1I ++ funct3 ++ rd ++ opcode )
    where funct3 = "111"

instJalr :: String -> String -> String -> String -> String -> String
instJalr x immI rs1 rd opcode = reverse ( immI ++ rs1 ++ funct3 ++ rd ++ opcode)
    where funct3 = "000"


-- Instrucoes do tipo S

instSb :: String -> String -> String -> String -> String -> String
instSb x immI rs2 rs1I opcode = reverse ( ( take 7 immI ) ++ rs2 ++ rs1I ++ funct3 ++ ( drop 7 immI ) ++ opcode )
    where funct3 = "000"

instSh :: String -> String -> String -> String -> String -> String
instSh x immI rs2 rs1I opcode = reverse ( ( take 7 immI ) ++ rs2 ++ rs1I ++ funct3 ++ ( drop 7 immI ) ++ opcode )
    where funct3 = "001"

instSw :: String -> String -> String -> String -> String -> String
instSw x immI rs2 rs1I opcode = reverse ( ( take 7 immI ) ++ rs2 ++ rs1I ++ funct3 ++ ( drop 7 immI ) ++ opcode )
    where funct3 = "010"

instSd :: String -> String -> String -> String -> String -> String
instSd x immI rs2 rs1I opcode = reverse ( ( take 7 immI ) ++ rs2 ++ rs1I ++ funct3 ++ ( drop 7 immI ) ++ opcode )
    where funct3 = "111"


-- Instrucoes do tipo SB

instBeq :: String -> String -> String -> String -> String -> String
instBeq x imm rs1 rs2 opcode = reverse ( imm1 ++ rs2 ++ rs1 ++ funct3 ++ imm2 ++ opcode )
    where funct3 = "000"
          imm1 = ( head imm ) : ( take 6 ( drop 2 imm ) )
          imm2 = ( drop 8 imm ) ++ ( imm !! 1 ):[  ]

instBne :: String -> String -> String -> String -> String -> String
instBne x imm rs1 rs2 opcode = reverse ( imm1 ++ rs2 ++ rs1 ++ funct3 ++ imm2 ++ opcode )
    where funct3 = "001"
          imm1 = ( head imm ) : ( take 6 ( drop 2 imm ) )
          imm2 = ( drop 8 imm ) ++ ( imm !! 1 ):[  ]

instBlt :: String -> String -> String -> String -> String -> String
instBlt x imm rs1 rs2 opcode = reverse ( imm1 ++ rs2 ++ rs1 ++ funct3 ++ imm2 ++ opcode )
    where funct3 = "100"
          imm1 = ( head imm ) : ( take 6 ( drop 2 imm ) )
          imm2 = ( drop 8 imm ) ++ ( imm !! 1 ):[  ]

instBge :: String -> String -> String -> String -> String -> String
instBge x imm rs1 rs2 opcode = reverse ( imm1 ++ rs2 ++ rs1 ++ funct3 ++ imm2 ++ opcode )
    where funct3 = "101"
          imm1 = ( head imm ) : ( take 6 ( drop 2 imm ) )
          imm2 = ( drop 8 imm ) ++ ( imm !! 1 ):[  ]

instBltu :: String -> String -> String -> String -> String -> String
instBltu x imm rs1 rs2 opcode = reverse ( imm1 ++ rs2 ++ rs1 ++ funct3 ++ imm2 ++ opcode )
    where funct3 = "110"
          imm1 = ( head imm ) : ( take 6 ( drop 2 imm ) )
          imm2 = ( drop 8 imm ) ++ ( imm !! 1 ):[  ]

instBgeu :: String -> String -> String -> String -> String -> String
instBgeu x imm rs1 rs2 opcode = reverse ( imm1 ++ rs2 ++ rs1 ++ funct3 ++ imm2 ++ opcode )
    where funct3 = "111"
          imm1 = ( head imm ) : ( take 6 ( drop 2 imm ) )
          imm2 = ( drop 8 imm ) ++ ( imm !! 1 ):[  ]

instLui :: String -> String -> String -> String -> String
instLui x immU rd opcode = reverse ( immU ++ rd ++ opcode )

instJal :: String -> String -> String -> String -> String
instJal x immU rd opcode = reverse ( imm ++ rd ++ opcode )
    where imm = ( head immU ) : ( drop 10 immU ) ++ ( head $ drop 9 immU ) : ( take 8 $ tail immU )

instBreak :: String -> String
instBreak x = reverse ( imm ++ rs1 ++ funct3 ++ rd ++ opcode )
    where imm = "000000000001"
          rs1 = "00000"
          funct3 = "000"
          rd = "00000"
          opcode = "1110011"

instNop :: String -> String
instNop x = reverse ( imm ++ rs1 ++ funct3 ++ rd ++ opcode )
    where imm = "000000000000"
          rs1 = "00000"
          funct3 = "000"
          rd = "00000"
          opcode = "0010011"








