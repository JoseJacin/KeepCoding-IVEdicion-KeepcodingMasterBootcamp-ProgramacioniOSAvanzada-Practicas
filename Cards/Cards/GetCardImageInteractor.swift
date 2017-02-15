//
//  GetCardImageInteractor.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez on 15/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

public class GetCardImageInteractor {
    let card: Card
    let manager: DeckOfCardsAPIManager
    
    // Initialization
    // Inicializador designado
    public init(card: Card, manager: DeckOfCardsAPIManager) {
        self.card = card
        self.manager = manager
    }
    
    // Inicializador de conveniencia
    public convenience init(card: Card) {
        self.init(card : card, manager: DeckOfCardsAPIManagerGCDImpl())
    }
    
    
    public func execute(completion: @escaping (UIImage) -> Void) {
        manager.downloadCardImage(card: self.card) { (image: UIImage) in
            assert(Thread.current == Thread.main)
            completion(image)
        }
    }
    
    
}
