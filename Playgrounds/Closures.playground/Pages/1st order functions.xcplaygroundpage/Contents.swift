// Funciones de primer órden
import Foundation

func add(n1: Int, n2: Int) -> Int {
    return n1 + n2
}

//Las funciones de primer nivel son las que reciben como parámetro funciones, no valores
func firstOrderExample(f: (Int, Int) -> Int) {
    let n = f(10, 20)
    print(n)
}

// Se puede usar pasándole una Trailing Closure
firstOrderExample { (n1: Int, n2: Int) -> Int in
    n1 + n2
}

// Se puede usar pasándole una función
firstOrderExample(f: add)

let addClosure = { (n1: Int, n2: Int) in
    return n1 + n2
}
let addClosure2 = addClosure

// Se puede usar pasándole un nombre de clausura
firstOrderExample(f: addClosure)
firstOrderExample(f: addClosure2)

addClosure(10, 40)

// 1st order functions: MAP
let basket = ["🍏", "🍎", "🍐", "🍋", "🍌", "🍌"]
// MAP. Aplica la función a cada uno de los elementos de la lista de forma paralela (usa un hilo por cada elemento).
// Dado que MAP es una función de primer nivel, se puede encadenar con otras funciones
// MAP == SQL UPDATE
// El retorno es un nuevo array(una copia), por lo tanto, los datos originales no se modifican. Retorna un NSMutable Array
basket.map({ (e: String) -> String in
   return "🍴" + e
})

basket.map { (e: String) -> String in
    "🍴" + e
}

basket.map { (e) -> String in
    "🍴" + e
}

basket.map { (e) in
    "🍴" + e
}

basket.map {
    "🍴" + $0
}

let a: [String] = basket.map {
    "🍴" + $0
}

func comer(s: String) -> String {
    return "💩"
}

func pelar(s: String) -> String {
    return "🍴" + s
}

basket.map(pelar)
basket.map(pelar).map(comer)

// FILTER == SQL SELECT
// El retorno es un nuevo array(una copia), por lo tanto, los datos originales no se modifican. Retorna un NSMutable Array
basket.filter {
    $0 == "🍌"
}

// Se puede concatenar
basket.filter {
    $0 == "🍌"
}.map(pelar)

basket.filter {
    $0 == "🍌"
}.map(pelar).map(comer)

// REDUCE
// Coge todos los elementos, y partiendo de un valor inicial, retorna uno solo
let numbers = [82, 28, 8, 872, 72]

let n = numbers.map { $0 * 2 }.reduce(0, +)
numbers.reduce(1, *)
n

// SORT
[1, 2, 4, 5, 1].sorted()
[1, 2, 4, 5, 1].sorted { (n1: Int, n2: Int) -> Bool in
    n1 < n2
}
[1, 2, 4, 5, 1].sorted { (n1: Int, n2: Int) -> Bool in
    n1 > n2
}
[1, 2, 4, 5, 1].sorted {
    $0 > $1
}
[1, 2, 4, 5, 1].sorted {
    $0 > $1
    }.map{ $0 * 2 }

// FLATMAP
// Aplana los datos, es decir, si hay un array de arrays, lo aplana todo en un solo array
let array = [[2, 3], [2], [], [4, 5]]
let x = array.flatMap { $0 }
x
let z = array.flatMap { $0 }.map { $0 + 2 }
z



