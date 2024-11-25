-- FILE: test_Hoffman.hs
import Hoffman
import qualified Data.Map as Map
import Test.HUnit

-- Test nuevoHoffman
testNuevoHoffman = TestCase $ do
    let hoja = nuevoHoffman 'a'
    assertEqual "nuevoHoffman 'a'" (Hoja 'a') hoja

-- Test fusionHoffman
testFusionHoffman = TestCase $ do
    let h1 = nuevoHoffman 'a'
    let h2 = nuevoHoffman 'b'
    let nodo = fusionHoffman h1 h2
    assertEqual "fusionHoffman (Hoja 'a') (Hoja 'b')" (Nodo (Hoja 'a') (Hoja 'b')) nodo

-- Test obtenerCaracter
testObtenerCaracter = TestCase $ do
    let hoja = nuevoHoffman 'a'
    assertEqual "obtenerCaracter (Hoja 'a')" 'a' (obtenerCaracter hoja)

-- Test arbolIzquierdo
testArbolIzquierdo = TestCase $ do
    let h1 = nuevoHoffman 'a'
    let h2 = nuevoHoffman 'b'
    let nodo = fusionHoffman h1 h2
    assertEqual "arbolIzquierdo (Nodo (Hoja 'a') (Hoja 'b'))" h1 (arbolIzquierdo nodo)

-- Test arbolDerecho
testArbolDerecho = TestCase $ do
    let h1 = nuevoHoffman 'a'
    let h2 = nuevoHoffman 'b'
    let nodo = fusionHoffman h1 h2
    assertEqual "arbolDerecho (Nodo (Hoja 'a') (Hoja 'b'))" h2 (arbolDerecho nodo)

-- Test codificacion
testCodificacion = TestCase $ do
    let h1 = nuevoHoffman 'a'
    let h2 = nuevoHoffman 'b'
    let nodo = fusionHoffman h1 h2
    let expected = Map.fromList [('a', "0"), ('b', "1")]
    assertEqual "codificacion (Nodo (Hoja 'a') (Hoja 'b'))" expected (codificacion nodo)

-- Additional tests

-- Test obtenerCaracter with Nodo
testObtenerCaracterNodo = TestCase $ do
    let nodo = fusionHoffman (nuevoHoffman 'a') (nuevoHoffman 'b')
    assertRaises "obtenerCaracter (Nodo _ _)" (ErrorCall "El árbol no es una hoja") (evaluate $ obtenerCaracter nodo)

-- Test arbolIzquierdo with Hoja
testArbolIzquierdoHoja = TestCase $ do
    let hoja = nuevoHoffman 'a'
    assertRaises "arbolIzquierdo (Hoja 'a')" (ErrorCall "El árbol no es una rama") (evaluate $ arbolIzquierdo hoja)

-- Test arbolDerecho with Hoja
testArbolDerechoHoja = TestCase $ do
    let hoja = nuevoHoffman 'a'
    assertRaises "arbolDerecho (Hoja 'a')" (ErrorCall "El árbol no es una rama") (evaluate $ arbolDerecho hoja)

-- Test codificacion with more complex tree
testCodificacionCompleja = TestCase $ do
    let h1 = nuevoHoffman 'a'
    let h2 = nuevoHoffman 'b'
    let h3 = nuevoHoffman 'c'
    let nodo1 = fusionHoffman h1 h2
    let nodo2 = fusionHoffman nodo1 h3
    let expected = Map.fromList [('a', "00"), ('b', "01"), ('c', "1")]
    assertEqual "codificacion (Nodo (Nodo (Hoja 'a') (Hoja 'b')) (Hoja 'c'))" expected (codificacion nodo2)

-- Run tests
main :: IO Counts
main = runTestTT $ TestList [
    testNuevoHoffman,
    testFusionHoffman,
    testObtenerCaracter,
    testArbolIzquierdo,
    testArbolDerecho,
    testCodificacion,
    testObtenerCaracterNodo,
    testArbolIzquierdoHoja,
    testArbolDerechoHoja,
    testCodificacionCompleja
    ]