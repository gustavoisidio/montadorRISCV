import Numeric (showHex, showIntAtBase)
--import Data.Char (intToDigit)
import System.IO
import Data.Char

main = do
    contents <- readFile "instructions.txt"
--    writeFile "girlfriendcaps.txt" ( unlines (jtoUpper ( lines contents ) ) )  
    writeFile "intructions.mif" ( map ( \x -> case x of ',' ->  ' '; ')' -> ' '; '(' -> ' '; _ -> x) contents)

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
instst = "add x5,x3,x0" :: String

-- Recebe uma instrucao e decodifica qual instrucao se trata
instDecod :: String -> String
instDecod x | ( x!!0 == 'a' ) && ( x!!1 == 'd' ) && ( x!!2 == 'd' ) = instAdd x
            | otherwise = "Instrucao nao identificada"

-- Trata a instrucao ADD
instAdd :: String -> String
instAdd x = opcode ++ rd ++ funct3 ++ rs1 ++ rs2 ++ funct7 
    where instCleaned = words $ map ( \x -> case x of ',' ->  ' '; ')' -> ' '; '(' -> ' '; _ -> x) x
          opcode = "opcode: 0110011 "
          funct3 = " funct3: 000 "
          funct7 = " funct7: 0000000"
          rs1 = "rs1: " ++ ( roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 2 ) ) 
          rs2 = " rs2: " ++ ( roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 3 ) ) 
          rd = "rd: " ++ ( roundBin 5 ( intToBin $ drop 1 $ instCleaned !! 1 ) )
           


