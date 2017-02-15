import Foundation

func calculator1(n1: Int, n2: Int, opCode: Int) -> Int {
    switch opCode {
    case 1:
        return n1 + n2
    case 2:
        return n1 - n2
    default:
        return 0
    }
}

calculator1(n1: 10, n2: 20, opCode: 1)
calculator1(n1: 10, n2: 20, opCode: 2)

// Aumentar la funcionalidad de calculator1 mediante clausuras
typealias integerOperation = (Int, Int) -> Int

let add: integerOperation = { (n1, n2) in
    n1 + n2
}

let substract: integerOperation = { (n1, n2) in
    n1 - n2
}

add(10, 20)
substract(4, 7)

func calculatorDeLuxe(n1: Int, n2: Int, op: integerOperation) -> Int {
    return op(n1, n2)
}

calculatorDeLuxe(n1: 10, n2: 20, op: add)
calculatorDeLuxe(n1: 10, n2: 20, op: substract)

let multiply: integerOperation = { (n1, n2) in
    n1 * n2
}

let divide: integerOperation = { (n1, n2) in
    if (n2 == 0) {
        return 0
    }
    return n1 / n2
}

calculatorDeLuxe(n1: 10, n2: 20, op: multiply)
calculatorDeLuxe(n1: 20, n2: 2, op: divide)
calculatorDeLuxe(n1: 20, n2: 0, op: divide)