module RARisimo (
    frecuencias,
    ganadores,
    hoffman,
    rarisimo
) where

import qualified Data.Map as Map
import Data.Map (Map)
import Data.List (group, sort, sortOn)
import Frecuencia
import Hoffman

type FrecuenciaH = (Char, Hoffman)

frecuencias :: String -> [FrecuenciaH]
frecuencias str = map (\xs -> (head xs, nuevoHoffman (head xs))) groupedChars
    where
        groupedChars = group . sort $ str
        nuevoHoffman c = Hoja c

ganadores :: [FrecuenciaH] -> Maybe (FrecuenciaH, FrecuenciaH, [FrecuenciaH])
ganadores xs
    | length xs < 2 = Nothing
    | otherwise = Just (min1, min2, rest)
    where
        sorted = sortOn (\(_, h) -> freq h) xs
        min1 = head sorted
        min2 = sorted !! 1
        rest = drop 2 sorted
        freq (Hoja _) = 1  -- Asignar una frecuencia fija para las hojas
        freq (Nodo izq der) = freq izq + freq der  -- Sumar las frecuencias de los subárboles

hoffman :: String -> Maybe Hoffman
hoffman "" = Nothing
hoffman str = buildTree (frecuencias str)
    where
        buildTree [(_, tree)] = Just tree
        buildTree xs = case ganadores xs of
            Nothing -> Nothing
            Just ((_, t1), (_, t2), rest) -> buildTree (insertar (fusionHoffman t1 t2) rest)
        freq (Hoja c) = 1  -- Asignar una frecuencia fija para las hojas
        freq (Nodo izq der) = freq izq + freq der  -- Sumar las frecuencias de los subárboles
        insertar nuevo [] = [(undefined, nuevo)]
        insertar nuevo ((c, h):hs)
            | freq nuevo <= freq h = (undefined, nuevo) : (c, h) : hs
            | otherwise = (c, h) : insertar nuevo hs

rarisimo :: String -> Map.Map Char String
rarisimo str = case hoffman str of
    Nothing -> Map.empty
    Just tree -> codificacion tree
    where
        codificacion (Hoja c) = Map.singleton c ""
        codificacion (Nodo izq der) = Map.union (Map.map ("0" ++) (codificacion izq))
                           (Map.map ("1" ++) (codificacion der))