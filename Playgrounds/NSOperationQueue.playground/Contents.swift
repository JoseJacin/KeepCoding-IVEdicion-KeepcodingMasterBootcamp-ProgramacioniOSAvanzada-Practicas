import UIKit

// Se imprime el hilo en el que estamos para saber que nos encontramos en el hilo principal
print(Thread.current.description)

// Se crea una clausura que repite código
let repeatClosure = { (s: String) -> () in
    for i in 0...10 {
        print(s + " " + Thread.current.description)
    }
}

// Se puede cambiar el nombre de la clausura
let r = repeatClosure

// Se crea una propiedad de tipo OperationQueue
let queue = OperationQueue()

// Se extiende una clase de Operation
class MyOp: Operation {
    let m: String
    
    init(message: String) {
        self.m = message
    }
    
    override func main() {
        repeatClosure("***** I'm \( m ) in main")
    }
}

let op = MyOp(message: "***Jose***")
let op2 = MyOp(message: ">>>Jacin<<<")

// Con addDependency se añade dependencia. Hasta que no termine un hilo, no comienza el otro
op2.addDependency(op)
queue.addOperation(op)
queue.addOperation(op2)

print("---------------------------------------------------------")
queue.cancelAllOperations()

queue.addOperation {
    r("Hello")
}

queue.addOperation {
    repeatClosure("is it me")
}

queue.addOperation {
    repeatClosure("you're looking for?")
}






















