//
//  Notebook+Utils.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 21/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import CoreData

extension Notebook {
    // Función que recupera los primeros 20 registros y los ordena por Nombre (title)
    class func fetchRequestOrderedByName() -> NSFetchRequest<Notebook> {
        let fetchRequest: NSFetchRequest<Notebook> = Notebook.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        // Se establece el orden de los resultados
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
}
