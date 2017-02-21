//
//  AppDelegate.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 20/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var context: NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Creamos un contexto
        let container = persistentContainer(dbName: "Everpobre") { (error: NSError) in
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        
        context = container.viewContext
        injectContextToFirstViewController()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let context = self.context else { return }
        saveContext(context: context)
    }
    
    
    func injectContextToFirstViewController() {
        if let navController = window?.rootViewController as? UINavigationController,
           let initialViewController = navController.topViewController as? NotebooksController {
            initialViewController.context = self.context
        }
    }
}

