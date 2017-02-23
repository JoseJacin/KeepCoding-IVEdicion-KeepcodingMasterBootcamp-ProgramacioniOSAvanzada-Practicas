//
//  NotebookCell.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 21/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

class NotebookCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberNotesLabel: UILabel!
    
    private var _notebook: Notebook? = nil
    var notebook: Notebook {
        get {
           return _notebook!
        }
        set {
            _notebook = newValue
            titleLabel.text = newValue.title
            if let n = newValue.notes?.count {
                numberNotesLabel.text = "\( n ) notes"
            }
        }
    }
}
