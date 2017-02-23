//
//  Note+Utils.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 21/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import CoreData

extension Note {
    // Función que recupera los primeros 20 registros y los ordena por Nombre (title)
    class func notesFrom(notebook: Notebook) -> NSFetchRequest<Note> {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        // Se establece el orden de los resultados
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Se establece el predicado, es decor, el filtro
        fetchRequest.predicate = NSPredicate(format: "notebook = %@", notebook)
        
        return fetchRequest
    }
}
