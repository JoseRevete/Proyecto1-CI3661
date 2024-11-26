module Main(main) where

import RARisimo(frecuencias, ganadores, hoffman, rarisimo)
import Control.Monad
import System.IO
import Hoffman
import Data.Map

main :: IO()
main = do
    menu 
    line <- getLine

    unless (line == "Salir") $ do

        if (line == "Codificar")
            then codificar


        else if (line == "Decodificar")
            then putStrLn "A"
        else if (line == "Analizar")
            then putStrLn "p"

        else putStrLn "\nOpción invalida"

        main


menu :: IO()
menu = do
    putStrLn "\nElige una opción:\n -Codificar\n -Decodificar\n -Analizar\n -Salir" 

codificar :: IO()
codificar = do
    putStrLn "\nInserte el PATH del archivo a codificar:"
    path <- getLine
    file <- openFile path ReadMode
    contents <- hGetContents file
    let m = rarisimo contents
    let path_raro = path ++ ".raro"
    
    let b = iterar_string contents m
    
    writeFile path_raro b


iterar_string :: String -> Map Char String -> String
iterar_string "" m = ""
iterar_string (x:xs) m = do
    let z = Data.Map.lookup x m

    (maybe "" id z) ++ iterar_string xs m
