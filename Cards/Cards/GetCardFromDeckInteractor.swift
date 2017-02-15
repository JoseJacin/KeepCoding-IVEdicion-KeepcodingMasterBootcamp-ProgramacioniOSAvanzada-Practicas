//
//  GetCardFromDeckInteractor.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez on 14/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation

public class GetCardFromDeckInteractor {
    let deck: Deck
    let manager: DeckOfCardsAPIManager
    
    // Initialization
    // Inicializador designado
    public init(deck: Deck, manager: DeckOfCardsAPIManager) {
        self.deck = deck
        self.manager = manager
    }

    // Inicializador de conveniencia
    public convenience init(deck: Deck) {
        self.init(deck: deck, manager: DeckOfCardsAPIManagerGCDImpl())
    }
    
    public func execute(completion: @escaping (Card) -> Void) {
        manager.downloadCard(deck: deck) { (card: Card) in
            assert(Thread.current == Thread.main)
            completion(card)
        }
    }
}
