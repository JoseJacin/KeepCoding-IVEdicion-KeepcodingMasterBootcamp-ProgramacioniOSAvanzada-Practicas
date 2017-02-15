import UIKit

print(Thread.current.description)

//assert(Thread.current == Thread.main)
//Thread.sleep(forTimeInterval: 1000)

// Hay 3 tipos de colas
// La principal. Es serial, hasta que no acaba la tarea 1 no empieza la tarea 2
// Una serie de colas concurrentes. Primero arranca la tarea 1 y después la 2, pero no espera a finalizar la tarea 1 para ejecutar la tarea 2, por lo que se ejecutan a la vez
// Colas manuales. Pueden ser seriales o concurrentes

print("Create serial queue")

// Se crea una cola normal. Serial
let queue = DispatchQueue(label: "io.JoseJacin.serial")

// sync. Bloquea el hilo en el que estamos. Por ejemplo, si estamos en el hilo principal (main), este espera a que la cola a la que se le pasa el código termine sus tareas
// async. No bloquea el hilo en el que estamos. Por ejemplo, si estamos en el hilo principal (main), este no espera a que la cola a la que se le pasa el código termine sus tareas

// Tarea 1
queue.async {
    for i in 1...10 {
       print("😃 *** task 1 \(i) " + Thread.current.description)
    }
}

print("En main, checkpoint 1")

// Tarea 2
queue.async {
    print("😈 --- task 2 " + Thread.current.description)
}

print("En main, checkpoint 2")



