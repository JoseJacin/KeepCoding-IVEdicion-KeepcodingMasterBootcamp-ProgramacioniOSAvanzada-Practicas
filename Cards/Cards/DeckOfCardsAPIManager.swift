//
//  DeckOfCardsAPIManager.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez Brito on 14/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

public typealias ErrorClosure = (Error) -> Void

public protocol DeckOfCardsAPIManager {
    
    func downloadDeck(completion: @escaping (Deck) -> Void)
    func downloadDeck(completion: @escaping (Deck) -> Void, onError: ErrorClosure?)
    func downloadCard(deck: Deck, completion: @escaping (Card) -> Void)
    func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void)
}
