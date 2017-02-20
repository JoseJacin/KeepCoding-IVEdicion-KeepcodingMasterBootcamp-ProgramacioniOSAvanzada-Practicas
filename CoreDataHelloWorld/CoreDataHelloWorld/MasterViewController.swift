//
//  MasterViewController.swift
//  CoreDataHelloWorld
//
//  Created by Jose Sanchez Rodriguez on 15/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Se añade
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        // Se añade el botón
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        obtainReferenceToDetailViewControllerFromSplitViewControllerForUserIDontKnowWhen()
    }

    // Función que controla si se encuentra en un splitViewController y recupera con controller que tiene
    // Esta función se puede sacar a una clase de "ayuda" inyectándole el self.splitViewController.
    // De esta forma la función se puede testear y ya sería rehusable
    func obtainReferenceToDetailViewControllerFromSplitViewControllerForUserIDontKnowWhen() {
        // Si nos encontramos en un splitViewController se recuperan todos los controller del splitViewController
        if let split = self.splitViewController {
            // Se recuperan todos los splirViewController
            let controllers = split.viewControllers
            // Nos quedamos con el detailViewController del splitViewController
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // Función que inserta un nuevo objeto
    func insertNewObject(_ sender: Any) {
        guard let context = self.managedObjectContext else { return }
        
        let newEvent = Event(context: context)
        newEvent.timestamp = NSDate()

        // Save the context.
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // MARK: - Segues
    // Método que se ejecuta cuando se está haciendo una transición
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = self.fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let event = self.fetchedResultsController.object(at: indexPath)
        self.configureCell(cell, withEvent: event)
        return cell
    }

    // Función que retorna si se pueden editar filas del tableView
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Función que se ejecuta cuando se realiza una acción sobre el tableView
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Se consulta si el estilo de borrado es delete
        if editingStyle == .delete {
            // Se recupera el contexto
            let context = self.fetchedResultsController.managedObjectContext
            // Se elimina el objeto
            context.delete(self.fetchedResultsController.object(at: indexPath))
                
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func configureCell(_ cell: UITableViewCell, withEvent event: Event) {
        cell.textLabel!.text = event.timestamp!.description
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<Event> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        _fetchedResultsController?.delegate = self
        
        do {
            // Descarga el primer bloque de registros (20)
            try _fetchedResultsController!.performFetch()
        } catch {
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController<Event>? = nil

    // MARK: - NSFetchedResultController delegate
    // Función que indica que se va iniciar un cambio en el contenido del contexto
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }

    // Función que se ejecuta cuando se crea/elimina una sección (groupBy) en el fetchedresultsController
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        // Se actualiza la tableView
        switch type {
            case .insert:
                self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    // Función que se ejecuta cuando una sección se ha modificado (insert/delete/update/move) un registro en el contexto
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                self.configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
            case .move:
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    // Función que indica que se a finalizado un cambio en el contenido del contexto
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

