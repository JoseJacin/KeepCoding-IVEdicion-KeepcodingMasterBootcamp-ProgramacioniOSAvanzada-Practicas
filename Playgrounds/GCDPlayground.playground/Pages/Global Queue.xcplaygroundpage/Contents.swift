import Foundation

// Cola concurrente. Primero arranca la tarea 1 y después la 2, pero no espera a finalizar la tarea 1 para ejecutar la tarea 2, por lo que se ejecutan a la vez
// Tiene una QoS (Quality Os service) o prioridad .backgroud, lo que quiere decir que es la prioridad más baja
DispatchQueue.global(qos: .background).async {
    for i in 1...10 {
        print("👻 +++ task 3 \(i) " + Thread.current.description)
    }
}

// Tiene una QoS (Quality Os service) o prioridad .default, lo que quiere decir que es la prioridad intermedia
DispatchQueue.global().async(execute: { () -> Void in
    print("Hola")
    
    for i in 1...10 {
        print("😃 *** task 1 \(i) " + Thread.current.description)
    }
})

// Tiene una QoS (Quality Os service) o prioridad .default, lo que quiere decir que es la prioridad intermedia
DispatchQueue.global().async(execute: { () -> Void in
    print("Hola")
    
    for i in 1...10 {
        print("😈 --- task 2 \(i) " + Thread.current.description)
    }
})

// Tiene una QoS (Quality Os service) o prioridad .userInteractive, lo que quiere decir que es la prioridad más alta
DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
    for i in 1...10 {
        print("🤖 >>> task 4 \(i) " + Thread.current.description)
    }
}