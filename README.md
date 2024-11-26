# Proyecto I: RARísimo

Elaborador por:
**Ian Garcia 19-10040**
**Jesus Gutierrez 20-10332**
**Jose Revete 19-10087**

Este proyecto implementa un algoritmo de codificación de Hoffman utilizando varios módulos en el lenguaje Haskell. Los módulos incluidos son `Frecuencia`, `Hoffman`, `RARisimo` y `Cliente`.

- Para compilar: `ghc -o rarisimo Cliente.hs`

- Para ejecutar: `./rarisimo`

## Módulo Frecuencia

El módulo `Frecuencia` proporciona un tipo de dato y funciones para manejar las ocurrencias para un valor de algun tipo comparable por igualdad. Este módulo es útil para contar la ocurrencia de elementos en una lista y acceder tanto a sus valores como a sus frecuencias.

### Tipo de Dato: Frecuencia

```hs
newtype Frecuencia a = Frecuencia (a, Int)
    deriving (Show, Eq)
```
El tipo Frecuencia es un newtype que encapsula una tupla `(a, Int)`, donde `a` es el valor y `Int` es representa frecuencia de ese valor.

### Funciones

- `iniciarFrecuencia :: Eq a => a -> Frecuencia a` \
Crea una nueva instancia de Frecuencia con una frecuencia inicial de 1.

- `contar :: Eq a => a -> [a] -> Frecuencia a`\
Cuenta la ocurrencia de un elemento en una lista y devuelve una instancia de Frecuencia con el valor y su frecuencia.

- `valor :: Frecuencia a -> a`\
Devuelve el valor almacenado en una instancia de Frecuencia.

- `frecuencia :: Frecuencia a -> Int`
Devuelve la frecuencia del valor almacenado en una instancia de Frecuencia.

El módulo también define una instancia de la clase `Ord` para Frecuencia, permitiendo la comparacion de este tipo de dato lo cual admite ordenar listas de `Frecuencia`.

## Modulo Hoffman
El módulo `Hoffman` define el tipo de dato para representar un árbol de Hoffman y proporciona funciones para construir y manipular dichos árboles.

### Tipo de Dato: Hoffman
```hs
data Hoffman = Hoja Char 
             | Nodo Hoffman Hoffman 
             deriving (Eq)
```
El tipo Hoffman se define de tal forma que puede ser una Hoja, que contiene un caracter, o un Nodo que contiene dos subárboles.

### Funciones

- `nuevoHoffman :: Char -> Hoffman`\
Crea una nueva hoja de Hoffman dado un caracter ingresado.

- `fusionHoffman :: Hoffman -> Hoffman -> Hoffman`\
Fusiona dos árboles de Hoffman en un nuevo Nodo, creando asi un nuevo arbol.

- `obtenerCaracter :: Hoffman -> Char`\
Devuelve el caracter almacenado en una hoja de Hoffman.

- `arbolIzquierdo :: Hoffman -> Hoffman`\
Devuelve el subárbol izquierdo de un Nodo de Hoffman.

- `arbolDerecho :: Hoffman -> Hoffman`\
Devuelve el subárbol derecho de un Nodo de Hoffman. 

- `codificacion :: Hoffman -> Map Char String`\
Genera un mapa de codificación (diccionario) para cada caracter en el árbol de Hoffman.

El módulo también define instancias de las clases `Show` y `Read` para el tipo de dato `Hoffman`, permitiendo la conversión de un arbol a cadena de caracteres y permitiendo la lectura de dichas cadenas para crear un árbol.

## Modulo RARisimo

El módulo `RARisimo` utiliza los módulos `Frecuencia` y `Hoffman` para implementar la construcción de un árbol de Hoffman, a partir de las frecuencias de los caracteres de una cadena dada.

### Funciones

- `frecuencias :: String -> [Frecuencia Char]`\
Calcula la cantidad de ocurrencias de cada uno de los caracteres de una cadena dada y los convierte almacena en una lista de instancias del tipo `Frecuencia`.

- `ganadores :: [Frecuencia Char] -> Maybe (Frecuencia Char, Frecuencia Char, [Frecuencia Char])`\
Encuentra los dos elementos con las frecuencias más bajas en una lista de frecuencias y devuelve una tupla con estos dos elementos y la lista restante.

- `hoffman :: String -> Maybe Hoffman`\
Construye una representacion de la cadena como árbol de Hoffman a partir de la frecuencia de cada caracter de la misma. Devuelve Nothing si la cadena está vacía.

- `rarisimo :: String -> Map Char String`\
Genera el mapa de codificación de Hoffman para una cadena dada a partir del arbol que genera la funcion `hoffman` y calculando su codificacion mediante la funcion `codificacion` del modulo `Hoffman`.

## Cliente

El módulo `Cliente` proporciona una interfaz de línea de comandos para interactuar con el algoritmo de codificación de Hoffman, permitiendole al usuario codificar, decodificar y analizar archivos de texto.

### Codificar
Se verifica si el archivo existe. En tal caso se lee el contenido del archivo para crear su representacion en arbol de Hoffman usando la funcion `hoffman` del modulo `RARisimo`. Luego para la codificacion de cada caracter, se utiliza la funcion `rarisimo` del modulo `RARisimo` para generar la cadena codificada. Se genera la nueva ruta para el archivo codificado añadiendo la extensión `.raro` a la ruta original. Finalmente se escribe en el nuevo archivo codificado la representación del árbol de Hoffman y la cadena codificada.

### Decodificar
En construccion :smile:

### Analizar
Solicita al usuario el path de un archivo y verifica si existe. Si el archivo existe, obtiene su tamaño original, lee su contenido y obtiene la representación binaria del contenido utilizando la función rarisimo. Luego calcula el tamaño del archivo codificado y el porcentaje de ganancia o pérdida en tamaño al codificar el archivo. Finalmente, presenta un reporte con el tamaño del archivo original, el tamaño del archivo codificado y el porcentaje de ganancia o pérdida. Si el archivo no existe, informa al usuario que el archivo no existe.