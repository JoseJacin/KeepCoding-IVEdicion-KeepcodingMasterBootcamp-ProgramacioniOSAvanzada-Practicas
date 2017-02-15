//
//  DeckInteractor.swift
//  Cards
//
//  Created by Diego Freniche Brito on 14/2/17.
//  Copyright © 2017 freniche. All rights reserved.
//

import Foundation

public class DeckInteractor {
    public func execute(completion: @escaping (Deck) -> Void) {
        DeckOfCardsAPIManager().downloadDeck { (deck: Deck) in
            assert(Thread.current == Thread.main)

            completion(deck)
        }
    }
}
