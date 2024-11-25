module Main(main) where

import RARisimo(frecuencias, ganadores, hoffman, rarisimo)
import Control.Monad
import System.IO


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
    --a <- rarisimo contents
    putStrLn contents

