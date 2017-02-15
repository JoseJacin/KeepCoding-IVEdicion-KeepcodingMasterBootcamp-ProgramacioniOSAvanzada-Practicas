import Foundation

// Se crea una cola concurrente.
// Cola concurrente. Primero arranca la tarea 1 y después la 2, pero no espera a finalizar la tarea 1 para ejecutar la tarea 2, por lo que se ejecutan a la vez
let concurrentQueue = DispatchQueue(label: "io.JoseJacin.concurrent", attributes: DispatchQueue.Attributes.concurrent)

print("Create concurrence queue")
print("Beginning")
// Tarea 1
concurrentQueue.async {
    for i in 1...10 {
        print("😃 *** task 1 \(i) " + Thread.current.description)
        
        // Se vuelve al hilo principal. Con sync no se vuelve al bucle for hasta que la tarea del hilo principal finalice
        DispatchQueue.main.sync {
            print("Hola desde background con sync\(i)")
        }
        
        // Se vuelve al hilo principal. Con async se continua con el bucle for hasta aunque la tarea del hilo principal no haya finalizado
        DispatchQueue.main.async {
            print("Hola desde background con async\(i)")
        }
    }
}

print("Middle")

// Tarea 2
concurrentQueue.async {
    for i in 1...10 {
        print("😈 --- task 2 \(i) " + Thread.current.description)
    }
}

print("End")
