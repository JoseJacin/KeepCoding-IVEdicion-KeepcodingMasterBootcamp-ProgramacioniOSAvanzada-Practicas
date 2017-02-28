//
//  AppDelegate.swift
//  SplitVC
//
//  Created by Diego Freniche Brito on 28/2/17.
//  Copyright © 2017 freniche. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        
        /*
         splitViewController.viewControllers
         When the split view interface is expanded, this property contains two view controllers; when it is collapsed, this property contains only one view controller. The first view controller in the array is always the primary (or master) view controller. If a second view controller is present, that view controller is the secondary (or detail) view controller.
        */
        
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        
        print(navigationController.topViewController!.title)
        
        /* 
        var displayModeButtonItem: UIBarButtonItem
        A button that changes the display mode of the split view controller.
 
        Incorporate this button into your user interface when you want to give the user an explicit way to change the display mode of the split view controller. Tapping this button changes the display mode to the value last returned by the delegate’s targetDisplayModeForAction(in:) method. Use that method to determine what mode to apply next based on the current configuration of the split view controller.
         */
 
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        return true
    }

   
    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            print("Collapsing")
            return true
        }
        print("Not Collapsing")

        return false
    }

}

