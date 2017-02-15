//
//  DeckInteractor.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez on 14/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation

public class DeckInteractor {
    let manager: DeckOfCardsAPIManager
    
    // Initialization
    // Inicializador designado
    public init(manager: DeckOfCardsAPIManager) {
        self.manager = manager
    }
    
    // Inicializador de conveniencia
    public convenience init() {
        self.init(manager: DeckOfCardsAPIManagerGCDImpl())
    }
    
    public func execute(completion: @escaping (Deck) -> Void) {
        manager.downloadDeck(completion: { (deck: Deck) in
            assert(Thread.current == Thread.main)
            completion(deck)
        })
        
        // La siguiente parte es lo mismo que lo anterior pero escrito de otra forma.
        // La clausura onError no es necesario escribirla ya que esta clausura es opcional y está inicializada con nil
        /*
        manager.downloadDeck(completion: { (deck: Deck) in
            
        }, onError: { (error: Error) in
            
        })
        */

        // LLamada sin pasárle el parámetro onError
        /*
        DeckOfCardsAPIManagerGCDImpl().downloadDeck { (deck: Deck) in

        }
        */
    }
}
