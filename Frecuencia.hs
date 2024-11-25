module Frecuencia (
  Frecuencia(..),
  iniciarFrecuencia,
  contar,
  valor,
  frecuencia
) where

newtype Frecuencia a = Frecuencia (a, Int)
    deriving (Show, Eq)

-- Funciones de construccion:
iniciarFrecuencia :: Eq a => a -> Frecuencia a
iniciarFrecuencia x = Frecuencia (x, 1)

contar :: Eq a => a -> [a] -> Frecuencia a
contar x xs = Frecuencia(x, length(filter (== x) xs))

-- Funciones de acceso: 
valor :: Frecuencia a -> a
valor (Frecuencia (x, _)) = x

frecuencia :: Frecuencia a -> Int
frecuencia (Frecuencia (_, n)) = n

-- Instancias:
instance Eq a => Ord (Frecuencia a) where
  compare f1 f2 = compare (frecuencia f1) (frecuencia f2)