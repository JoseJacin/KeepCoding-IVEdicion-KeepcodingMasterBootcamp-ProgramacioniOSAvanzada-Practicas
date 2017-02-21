//
//  AddEditNotebookController.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 21/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreData

class AddEditNotebookController: UIViewController {

    var context: NSManagedObjectContext?
    
    // Propiedades
    @IBOutlet weak var notebookNametextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        guard let context = self.context else { return }
        
        // Se crea un objeto de tipo Notebook
        let notebook = Notebook(context: context)
        notebook.creationDate = NSDate()
        notebook.title = self.notebookNametextField.text
        
        // Se graba el contecto
        saveContext(context: context)
        
        // Se sale del NavigationController y se retorna a la pantalla principal
        let _ = self.navigationController?.popViewController(animated: true)
    }
}
