//
//  DeckOfCardsAPIFakeImpl.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez Brito on 14/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

public class DeckOfCardsAPIManagerFake: DeckOfCardsAPIManager {
    public func downloadDeck(completion: @escaping (Deck) -> Void) {
        // Se invoca a la versión que tiene como segundo argumento una clausura de error
        self.downloadDeck(completion: completion, onError: nil)
    }
    
    // Con el paréntesis se indica que la clausura es opcional
    public func downloadDeck(completion: @escaping (Deck) -> Void, onError: ErrorClosure? = nil) {
        let deck = Deck(deckId: "4832")
        completion(deck)
    }
    
    public func downloadCard(deck: Deck, completion: @escaping (Card) -> Void) {
        let card = Card(code: "code", suit: "spades", image: "http://")
        completion(card)
    }
    
    public func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void) {
        let image = UIImage(named: "card")
        completion(image!)
    }
}
