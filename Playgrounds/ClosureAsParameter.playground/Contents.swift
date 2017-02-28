//: Playground - noun: a place where people can play

import UIKit

// Intro: al definir una clausura, le ponemos nombre a los argumentos que nos pasarán para usarlos en el código

let myClosure = { (i: Int, s: String) in
    print("i vale \(i), s vale \(s)")
}

// al invocar la clausura pasamos valores, sin indicar los nombres de los parámetros. Es entonces cuando se ejecuta ese código

myClosure(1, "Hello")

// revisando el ejemplo concreto del dataTask, tenemos este código

let session = URLSession.shared

let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
if let url = URL(string: urlString) {
    let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
        
        // aquí data, response y error vienen llenos. ¿Quién los llena?

    })
}

/* 
 el método dataTask recibe dos cosas:
- una url
- una clausura. Esta clausura es del tipo (Data?, URLResponse?, Error?) -> Void.
 
 Nosotros le pasamos el código que irá dentro de la clausura. Pero quien la invoca, quien la ejecuta, es dataTask. Y al invocarla "rellena" los parámetros
 
 Por verlo con un ejemplo, podríamos tener un método similar pero llamado myDataTask:
 */


extension URLSession {
    func myDataTask(with: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void) {
        // do something like create a new Task using GCD to download data from the Internet
        // ... when finished, call completionHandler
        let data = Data()
        let response = URLResponse()
        
        completionHandler(data, response, nil)  // <-- aquí llamamos a completionHandler, cuando ya tenemos los datos
    }
}