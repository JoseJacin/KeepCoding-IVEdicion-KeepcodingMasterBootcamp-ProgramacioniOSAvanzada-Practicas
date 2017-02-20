//
//  Person+inits.swift
//  CoreDataHelloWorld
//
//  Created by Jose Sanchez Rodriguez on 20/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import CoreData

extension Person {
    // Initializations
    // Inicializador de conveniencia
    public convenience init(context: NSManagedObjectContext, name: String) {
        self.init(context: context)
        
        self.name = name
    }
}
