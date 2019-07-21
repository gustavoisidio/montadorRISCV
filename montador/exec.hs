import Numeric (showHex, showIntAtBase)
--import Data.Char (intToDigit)
import System.IO
import Data.Char

main = do
    contents <- readFile "instructions.txt"
    writeFile "instructions.mif" ( unlines (programControll ( lines contents ) 0 ) )  
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

programControll :: [ String ] -> Int -> [ String ]
programControll _ 12 = [ ] 
programControll ( firstLine : otherLines ) index = ( instrTitle
                                                ++ instructionBinary1
                                                ++ instructionBinary2
                                                ++ instructionBinary3
                                                ++ instructionBinary4 ) 
                                                 : ( programControll otherLines ( index + 4 ) )
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
instDecod x | ( x!!0 == 'a' ) && ( x!!1 == 'd' ) && ( x!!2 == 'd' ) = instAdd x
            | otherwise = "Instrucao nao identificada"

-- Trata a instrucao ADD
instAdd :: String -> String
instAdd x = reverse ( funct7 ++ rs2 ++ rs1 ++ funct3 ++ rd ++ opcode ) 
    where instCleaned = words $ map ( \x -> case x of ',' ->  ' '; ')' -> ' '; '(' -> ' '; _ -> x) x
          opcode = "0110011"
          funct3 = "000"
          funct7 = "0000000"
          rs1 = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 2 ) 
          rs2 = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 3 ) 
          rd = roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 1 )




