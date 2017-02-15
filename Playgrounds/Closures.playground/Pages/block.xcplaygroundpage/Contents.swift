import Foundation

let limit = 10;

// Clausura que no recibe nada y no retorna nada
let closure: () -> () = {
    for i in 0...limit {
        print(i)
    }
}

closure()

let block = closure

block()

// Clausura que no recibe nada y retorna un entero
let newNumber: () -> Int = { () in
    return 10
}

// Clausura que recibe in entero y retorna un entero
let newNumber2: (Int) -> Int = { (n: Int) in
    return n * 10
}

newNumber()
newNumber2(5)


let concatName: (String, String) -> String = { (s1: String, s2: String) in
    return s1 + s2
}

typealias twoStringClosure = (String, String) -> String

let concatName2: twoStringClosure = { (s1: String, s2: String) in
    return s1 + s2
}

let concatName3 = { (s1: String, s2: String) in
    return s1 + s2
}

let concatName4 = { (s1: String, s2: String) in
    s1 + s2
}


concatName("Hola", " Mundo!")

// Forma más compacta de definir un bloque y ejecutarlo
let _ = {
    var secret = 10
    print ("Hola")
}()

let x: () -> (Int, Int) = {
    print("Estoy en X")
    
    return (19, 8)
}

// Acceder a la primera o segunda parte de la clausura
x().0
x().1

// Al definir una clausura y además se ejecuta, el tipo de entrada es el de salida
let y: (Int, Int) = {
    print("Estoy en X")
    
    return (19, 8)
}()
