module Hoffman (
    Hoffman(..),
    nuevoHoffman,
    fusionHoffman,
    obtenerCaracter,
    arbolIzquierdo,
    arbolDerecho,
    codificacion
) where

import qualified Data.Map as Map
import Data.Map (Map)

data Hoffman = Hoja Char | Nodo Hoffman Hoffman deriving (Eq)

instance Show Hoffman where
    show (Hoja c) = "Hoja " ++ show c
    show (Nodo izq der) = "Nodo (" ++ show izq ++ ") (" ++ show der ++ ")"

instance Read Hoffman where
    readsPrec _ input = 
        case input of
            ('H':'o':'j':'a':' ':rest) -> [(Hoja c, rest') | (c, rest') <- reads rest]
            ('N':'o':'d':'o':' ':rest) -> [(Nodo izq der, rest'') | 
                                            (izq, rest') <- reads rest, 
                                            (der, rest'') <- reads rest']
            _ -> []

nuevoHoffman :: Char -> Hoffman
nuevoHoffman c = Hoja c

fusionHoffman :: Hoffman -> Hoffman -> Hoffman
fusionHoffman h1 h2 = Nodo h1 h2

obtenerCaracter :: Hoffman -> Char
obtenerCaracter (Hoja c) = c
obtenerCaracter _ = error "El árbol no es una hoja"

arbolIzquierdo :: Hoffman -> Hoffman
arbolIzquierdo (Nodo izq _) = izq
arbolIzquierdo _ = error "El árbol no es una rama"

arbolDerecho :: Hoffman -> Hoffman
arbolDerecho (Nodo _ der) = der
arbolDerecho _ = error "El árbol no es una rama"

codificacion :: Hoffman -> Map Char String
codificacion = codificar ""

codificar :: String -> Hoffman -> Map Char String
codificar prefix (Hoja c) = Map.singleton c prefix
codificar prefix (Nodo izq der) =
    Map.union (codificar (prefix ++ "0") izq) (codificar (prefix ++ "1") der)