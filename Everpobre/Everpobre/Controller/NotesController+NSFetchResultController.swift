//
//  NotesController+NSFetchResultController.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 23/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import CoreData

extension NotesController: NSFetchedResultsControllerDelegate{
    // MARK: - Fetched results controller
    var fetchedResultsController: NSFetchedResultsController<Note> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: Note.notesFrom(notebook: self.notebook), managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "Master")
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
    
    // MARK: - NSFetchedResultController delegate
    // Función que indica que se va iniciar un cambio en el contenido del contexto
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    // Función que se ejecuta cuando se crea/elimina una sección (groupBy) en el fetchedresultsController
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        // Se actualiza la tableView
        switch type {
        case .insert:
            self.collectionView.insertSections(IndexSet(integer: sectionIndex))
        case .delete:
            self.collectionView.deleteSections(IndexSet(integer: sectionIndex))
        default:
            return
        }
    }
    
    // Función que se ejecuta cuando una sección se ha modificado (insert/delete/update/move) un registro en el contexto
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            collectionView.insertItems(at: [newIndexPath!])
        case .delete:
            collectionView.deleteItems(at: [indexPath!])
        default:
            break
            //self.configureCell(collectionView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
        }
    }
    
    // Función que indica que se a finalizado un cambio en el contenido del contexto
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
}
