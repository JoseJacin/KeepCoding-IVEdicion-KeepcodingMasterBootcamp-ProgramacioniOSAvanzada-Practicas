//
//  NotesController+UICollectionView.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 23/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

extension NotesController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Función que establece el número de secciones del collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    // Función que establece el número de items de cada sección del collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    // Función que retorna el item sobre el que se está realizando una acción
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Se crean la celda de cada item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        // Se configura la celda
        cell.note = self.fetchedResultsController.object(at: indexPath)
        
        // Se retorna la celda
        return cell
    }
}
