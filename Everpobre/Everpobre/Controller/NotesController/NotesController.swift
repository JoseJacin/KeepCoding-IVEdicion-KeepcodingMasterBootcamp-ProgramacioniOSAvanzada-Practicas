//
//  NotesController.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 23/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreData

class NotesController: UIViewController {

    var notebook: Notebook!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    internal var context: NSManagedObjectContext?
    internal var _fetchedResultsController: NSFetchedResultsController<Note>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = notebook.managedObjectContext
        
        self.title = notebook.title
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "AddNoteSegue" {
                let vc = segue.destination as! AddEditNoteController
                vc.notebook = self.notebook
            }
        }
    }
}
