import Numeric (showHex, showIntAtBase)
--import Data.Char (intToDigit)
import System.IO
import Data.Char

--widthFile = 0 :: Int
--depthFile = 0 :: Int 

main = do
    contents <- readFile "instructions.txt"
    writeFile "instructions.mif" ( unlines (headerFile ( lines contents ) 0 ( length ( lines contents ) ) ) )
--    putStr $ show ( length ( lines contents ) )  
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
     where fatbin = "000000000" ++ bin

-- String de teste
tst = "add x5,x3,x0" :: String

headerFile :: [ String ] -> Int -> Int -> [ String ]
headerFile instructions index width = header : ( programControll instructions index width ) 
    where header = ( "WIDTH = " ++ show width ++ ";\n\n"  
                  ++ "ADDRESS_RADIX = DEC;\n"
                  ++ "DATA_RADIX = BIN;\n\n"
                  ++ "CONTENT\n\n"
                  ++ "BEGIN\n"
                   )

programControll :: [ String ] -> Int -> Int -> [ String ]
programControll [  ] _ _ = "END;" : [  ]
programControll ( firstLine : otherLines ) index width | ( width * 4 ) == index = "END;" : [  ]
                                                       | otherwise = ( instrTitle
                                                                    ++ instructionBinary1
                                                                    ++ instructionBinary2
                                                                    ++ instructionBinary3
                                                                    ++ instructionBinary4 ) 
                                                                     : ( programControll otherLines ( index + 4 ) width )
      where instrTitle = ( "--" ++ firstLine ++ "\n" )
            instructionBinary = instDecod firstLine
            blockIndex1 = reverse . take 3 $ reverse $ "00" ++ show ( index + 1 )
            instructionBlock1 = reverse ( take 8 instructionBinary )
            instructionBinary1 = blockIndex1 ++ ": " ++ take 8 instructionBlock1 ++ ";\n"
            blockIndex2 = reverse . take 3 $ reverse $ "00" ++ show ( index + 2 )
            instructionBlock2 = reverse ( take 8 $ drop 8 instructionBinary )
            instructionBinary2 = blockIndex2 ++ ": " ++ take 8 instructionBlock2 ++ ";\n"
            blockIndex3 = reverse . take 3 $ reverse $ "00" ++ show ( index + 3 )
            instructionBlock3 = reverse ( take 8 $ drop 16 instructionBinary )
            instructionBinary3 = blockIndex3 ++ ": " ++ take 8 instructionBlock3 ++ ";\n"
            blockIndex4 = reverse . take 3 $ reverse $ "00" ++ show ( index + 4 )
            instructionBlock4 = reverse ( take 8 $ drop 24 instructionBinary )
            instructionBinary4 = blockIndex4 ++ ": " ++ take 8 instructionBlock4 ++ ";\n"

-- Recebe uma instrucao e decodifica qual instrucao se trata
instDecod :: String -> String
instDecod x = case ( head instCleaned ) of
                "add" -> instAdd x rs1 rs2 rd opcodeR
                "sub" -> instSub x rs1 rs2 rd opcodeR
                "sll" -> instSll x rs1 rs2 rd opcodeR
                "xor" -> instXor x rs1 rs2 rd opcodeR
                _     -> "Instrução não identificada"
    where instCleaned = words $ map ( \x -> case x of ',' ->  ' '; ')' -> ' '; '(' -> ' '; _ -> x) x
          rs1 = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 2 )
          rs2 = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 3 )
          rd = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 1 )
          opcodeR = "0110011"
          opcodeI1 = "0000011"
          opcodeI2 = "0010011"
          opcodeI3 = "1100111"
          opcodeS = "0100011"
          opcodeSB = opcodeI3
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



