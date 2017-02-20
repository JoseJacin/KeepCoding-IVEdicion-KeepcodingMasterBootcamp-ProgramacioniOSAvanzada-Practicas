//
//  DetailViewController.swift
//  CoreDataHelloWorld
//
//  Created by Jose Sanchez Rodriguez on 15/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    func configureView() {
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.timestamp!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        // Para la práctica se inserta un nuevo evento
        // Se crea un contexto que parta del contexto del detalle
        let context = detailItem?.managedObjectContext
        let ev = Event(context: context!)
        ev.timestamp = NSDate()
        
        // Aunque no es necesario, se fuerza la grabación del contexto
        do {
            try context?.save()
        } catch {
            
        }
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

