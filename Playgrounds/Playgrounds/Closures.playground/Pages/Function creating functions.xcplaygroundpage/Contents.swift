import Foundation

let c: () -> Int = { () in
    return 3
}

// Clausura que no recibe nada y retorna una clausura que no recibe nada y retorna un entero
let makeCounter: (String) -> ( () -> Int ) = { (s) in
    var n = 10
    
    // Es la función (closure) que se va a retornar
    let f: () -> Int = {
        n = n + 1
        return n
    }
    
    // Es la función (closure) que se va a retornar
    let f2: () -> Int = {
        n = n + n
        return n
    }
    
    // Es la función (closure) que se va a retornar
    let f3: () -> Int = {
        n = n * n
        return n
    }
    
    if (s == "") {
        return f2
    } else {
        return f3
    }
    
    return f
}

let c1: () -> Int = makeCounter("")
let c2 = makeCounter("a")
let c3 = makeCounter("b")

c1()

c3()

c1()
c1()
c1()
c2()
c2()