//
//  AppDelegate.swift
//  CoreDataHelloWorld
//
//  Created by Jose Sanchez Rodriguez on 15/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    let coreDataManager = CoreDataManager()
    var context: NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self

        let masterNavigationController = splitViewController.viewControllers[0] as! UINavigationController
        let controller = masterNavigationController.topViewController as! MasterViewController
        
        // Persistent Container
        //self.context = self.coreDataManager.persistentContainer(dbName: "CoreDataHelloWorld").viewContext
        let persistentContainer: NSPersistentContainer = self.coreDataManager.persistentContainer(dbName: "CoreDataHelloWorld")
        
        // Persistent Store: BBDD
        
        // Persistent Store Coordinatos
        //let persistentStoreCoordinator: NSPersistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        
        //Context
        self.context = persistentContainer.viewContext
        
        //Object model
        //persistentContainer.managedObjectModel
        
        testZone()
        
        controller.managedObjectContext = self.context
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.coreDataManager.saveContext(context: self.context!)
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    // MARK: - Test Zone
    // Función que añade objetos al contexto
    func testZone() {
        // Para evitar usar las ! se tiene que almacenar en un guard
        
        let ev1 = Event(context: self.context!)
        ev1.timestamp = NSDate()
        let ev2 = Event(context: self.context!)
        ev2.timestamp = NSDate();
        
        
        let person: Person = Person(context: self.context!)
        person.name = "Jose"
        person.address = "Jacin"
        person.married = true
        person.happy = true
        
        // Crear un objeto
        let marujita = Person(context: self.context!, name: "Marujita Díaz")
        
        // Saber los objetos que están pendientes de ser insertados
        print("Inserts --> ❤️: \(self.context!.insertedObjects.count)")
        
        self.coreDataManager.saveContext(context: self.context!)
        
        // Eliminar un objeto
        self.context!.delete(marujita) // Queda marcado para borrado
        print("Deletes --> 😇: \(marujita.isDeleted)")
        self.coreDataManager.saveContext(context: self.context!) // Aquí es donde se borra el objeto
        
        // Actualizar un objeto
        person.happy = false
        person.address = "under a bridge"
        print("Changes --> 🍎: \(self.context!.hasChanges)")
        
        // fetch: Consultar objetos gestionados en un contexto
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest() //Esto equivale a un SELECT * FROM PERSON
        // De esta forma también se puede realizar
        //let fetchRequest2 = NSFetchRequest<Person>(entityName: "Person")
        
        // Se indica que se quieren recuperar de 10 en 10 registros
        fetchRequest.fetchBatchSize = 10
        
        // Se puede ordenar
        // Se crea un sortDescriptor
        let orderByName = NSSortDescriptor(key: "name", ascending: true)
        let orderByAddress = NSSortDescriptor(key: "address", ascending: true)
        // Se crea un array de sortDescriptors
        fetchRequest.sortDescriptors = [orderByName, orderByAddress]
        // También que se puede hacer así
        /*
        fetchRequest.sortDescriptors= [NSSortDescriptor(key: "name", ascending: true),
                                       NSSortDescriptor(key: "address", ascending: true)]
        */
        
        do {
            let result = try self.context!.fetch(fetchRequest)
            print("Num records \(result.count)")
            
            // Se imprimen todos los registros
            for p in result {
                print("Name \(p.name), address \(p.address)")
            }
        } catch {
        
        }
        
        
        
    }
}

