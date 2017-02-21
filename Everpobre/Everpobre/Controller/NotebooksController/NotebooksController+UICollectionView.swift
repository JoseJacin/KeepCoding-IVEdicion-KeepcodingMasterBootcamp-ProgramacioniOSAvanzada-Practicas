//
//  NotebooksController+UICollectionView.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 21/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

extension NotebooksController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Función que establece el número de secciones del collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Función que establece el número de items de cada sección del collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    // Función que retorna el item sobre el que se está realizando una acción
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Se crean la celda de cada item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotebookCell", for: indexPath) as! NotebookCell
        // Se configura la celda
        cell.notebook = self.fetchedResultsController.object(at: indexPath)
        
        // Se retorna la celda
        return cell
    }
}
