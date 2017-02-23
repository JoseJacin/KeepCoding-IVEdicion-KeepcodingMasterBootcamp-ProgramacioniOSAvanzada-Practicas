//
//  AddEditNoteController.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 23/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

class AddEditNoteController: UIViewController {

    var notebook: Notebook!
    
    @IBOutlet weak var noteTitleTextView: UITextField!
    @IBOutlet weak var noteTextTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNoteButtonClicked(_ sender: Any) {
        guard let context = notebook.managedObjectContext else { return }
        
        let note = Note(context: context)
        note.title = self.noteTitleTextView.text
        note.text = self.noteTextTextView.text
        
        // Se crea la relación entre la note y el notebook
        // Forma 1
        //notebook.notes?.adding(note)
        // Forma 2
        //notebook.addToNotes(note)
        // Forma 3
        note.notebook = notebook
        
        saveContext(context: context)
        
        // Se sale del NavigationController y se retorna a la pantalla principal
        // Se puede hacer con programación funcional
        //popFunctional(nav: self.navigationController)
        // Se puede hacer con una Extensión
        popExtended(nav: self.navigationController)
    }
}
