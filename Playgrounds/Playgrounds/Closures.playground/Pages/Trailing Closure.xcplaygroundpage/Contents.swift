import Foundation

func downloadImage(imageName: String, completion: () -> () ) {
    
}

// Esto es lo mismo que lo anterior
typealias SimpleClosure = () -> ()
func downloadImage2(imageName: String, n: Int, completion: SimpleClosure ) {
    // Cosas
    
    // Cuando termino, se llama a completion
    completion()
}


downloadImage2(imageName: "Carmen de Mairena", n:10, completion: {
    print("Finalizado con éxito")
})

// Si el último parámetro de la función es una Trailing Closure se puede escribir de la siguiente forma
downloadImage2(imageName: "Carmen de Mairena", n: 10) {
    print("Finalizado con éxito")
}

func readJsonFromServer(url: String, succes: SimpleClosure, error: SimpleClosure) {
    let somethingWentWrong = true
    
    if (somethingWentWrong) {
        error()
    } else {
        succes()
    }
}

readJsonFromServer(url: "http://",
                   succes: {
    // Closure de success
}, error: {
    // Closure de error
})

// Es lo mismo que lo anterior
readJsonFromServer(url: "http://", succes: { 
    // Closure de success
}) { 
    // Closure de error
}
