//
//  NoteCell.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 23/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    private var _note: Note? = nil
    var note: Note {
        get {
            return _note!
        }
        set {
            _note = newValue
            titleLabel.text = newValue.title
            textLabel.text = newValue.text
        }
    }
}
