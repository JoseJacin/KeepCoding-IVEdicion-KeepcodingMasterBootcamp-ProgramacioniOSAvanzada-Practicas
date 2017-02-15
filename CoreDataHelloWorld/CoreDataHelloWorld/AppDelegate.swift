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
        self.context = self.coreDataManager.persistentContainer(dbName: "CoreDataHelloWorld").viewContext
        
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
        let ev1 = Event(context: self.context!)
        ev1.timestamp = NSDate()
        let ev2 = Event(context: self.context!)
        ev2.timestamp = NSDate()
        /*
        let person = Person(context: self.context!)
        person.name = "Jose"
        person.address = "Jacon"
        */
        //self.coreDataManager.saveContext(context: self.context!)
        self.coreDataManager.saveContext(context: self.context!)
    }
}

