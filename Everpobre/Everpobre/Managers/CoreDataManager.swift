//
//  CoreDataManager.swift
//  CoreDataHelloWorld
//
//  Created by Jose Sanchez Rodriguez on 15/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import CoreData

// MARK: - Core Data stack
public func persistentContainer(dbName: String, onError: ((NSError) -> Void)? = nil ) -> NSPersistentContainer {
    // Se crea un contenedor (BBDD) con el nombre indicado
    let container = NSPersistentContainer(name: dbName)
    // Se carga en memoria todo el contexto y se configura la BBDD según el contexto. Retorna si ha habido algún error
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError?,
           let onError = onError {
            //fatalError("Unresolved error \(error), \(error.userInfo)")
            onError(error)
        }
    })
    return container
}

// MARK: - Core Data Saving support
public func saveContext (context: NSManagedObjectContext) {
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
