module Main(main) where

import RARisimo(frecuencias, ganadores, hoffman, rarisimo)
import Control.Monad
import System.IO
import System.Directory
import Data.Map

main :: IO()
main = do
    menu 
    line <- getLine

    unless (line == "Salir") $ do

        if (line == "Codificar")
            then codificar


        else if (line == "Decodificar")
            then putStrLn "En construcción"
        else if (line == "Analizar")
            then putStrLn "En construcción"

        else putStrLn "\nOpción invalida"

        main


menu :: IO()
menu = do
    putStrLn "\nElige una opción:\n -Codificar\n -Decodificar\n -Analizar\n -Salir" 

codificar :: IO()
codificar = do
    putStrLn "\nInserte el PATH del archivo a codificar:"
    path <- getLine
    exists <- doesFileExist path 
    --Si existe el archivo, entonces empieza el proceso de codificar
    if exists
        then do
        
        file <- openFile path ReadMode
        --Se almacena el contenido del archivo
        contents <- hGetContents file
        --Se crea la representación del árbol de Hoffman correspondiente al contenido del archivo
        let rep_arbol = hoffman contents
        --Se hace uso de rarisimo para obtener la representación binaria de cada carácter contenido en el archivo
        let m = rarisimo contents
        let path_raro = path ++ ".raro"

        --Se convierte cada carácter de contenido en su representación binaria
        let b = iterar_string contents m

        --Se almacena dentro del archivo comprimido la representación del árbol de Hoffman y el contenido del archivo original en binario
        writeFile path_raro (show (rep_arbol) ++ "\n" ++ b)
        putStrLn $ "Se ha creado el nuevo archivo comprimido " ++ path_raro

    --Si no existe el archivo, se le avisa al usuario 
    else putStrLn "El archivo no existe" 



iterar_string :: String -> Map Char String -> String
iterar_string "" m = ""
iterar_string (x:xs) m = do
    let z = Data.Map.lookup x m

    (maybe "" id z) ++ iterar_string xs m
