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
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var topBackgroundConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundView.layer.cornerRadius = 10.0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.0, animations: { 
            self.backgroundView.frame = CGRect(x: self.backgroundView.frame.origin.x, y: 15, width: self.backgroundView.frame.width, height: self.backgroundView.frame.height)
            self.backgroundView.backgroundColor = UIColor.red
        }) { (b: Bool) in
            self.topBackgroundConstraint.constant = 15.0
        }
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
        popFunctional(nav: self.navigationController)
    }
    
    
}
