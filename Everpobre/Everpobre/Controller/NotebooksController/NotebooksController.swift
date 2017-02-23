//
//  ViewController.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 20/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreData

class NotebooksController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<Notebook>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Función que distingue el segue en el que se encuentra
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Se valida que segue se encuentre informado
        if let identifier = segue.identifier {
            // Se comprueba que se encuentra en el segue AddEditNotebookSegue
            if identifier == "AddEditNotebookSegue" {
                // Se obtiene el ViewController destino
                let vc = segue.destination as! AddEditNotebookController
                // Se le injecta el contexto
                vc.context = self.context
            }
            
            // Se comprueba que se encuentra en el segue AboutSegue
            if identifier == "AboutSegue" {
                // Nothing to do
            }
            
            // Se comprueba que se encuentra en el segue NotesSegue
            if identifier == "NotesSegue" {
                // Se retorna el primer elemento del item seleccionado (solo hay uno)
                let indexPath = collectionView.indexPathsForSelectedItems?.first
                let notebook = fetchedResultsController.object(at: indexPath!)
                // Se obtiene el ViewController destino
                let vc = segue.destination as! NotesController
                //notebook.notes
                vc.notebook = notebook
            }
        }
    }
}

