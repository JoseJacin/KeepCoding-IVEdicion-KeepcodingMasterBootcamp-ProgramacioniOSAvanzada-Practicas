//
//  DeckOfCardsAPIGCDImpl.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez Brito on 14/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

public class DeckOfCardsAPIManagerGCDImpl: DeckOfCardsAPIManager {
    public func downloadDeck(completion: @escaping (Deck) -> Void) {
        // Se invoca a la versión que tiene como segundo argumento una clausura de error
        self.downloadDeck(completion: completion, onError: nil)
    }
    
    // Con el paréntesis se indica que la clausura es opcional
    public func downloadDeck(completion: @escaping (Deck) -> Void, onError: ErrorClosure? = nil) {
        let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        
        DispatchQueue.global().async {
            if let url = URL(string: urlString) {
                do {
                    let data = try Data(contentsOf: url)
                    let deckJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                    
                    let deck = Deck(deckId: deckJson["deck_id"] as! String)
                    
                    DispatchQueue.main.async {
                        completion(deck)
                    }
                } catch {
                    print("Error in downloadDeck " + error.localizedDescription)
                    if let errorClosure = onError {
                        errorClosure(error)
                    }
                }
            }
        }
    }
    
    public func downloadCard(deck: Deck, completion: @escaping (Card) -> Void) {
        let urlString = "https://deckofcardsapi.com/api/deck/\( deck.deckId )/draw/?count=1"
        
        DispatchQueue.global().async {
            if let url = URL(string: urlString) {
                do {
                    let data = try Data(contentsOf: url)
                    let cardJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                    
                    let cards = cardJson["cards"] as! [Dictionary<String, Any>]
                    
                    let firstCard = cards[0]
                    
                    let card = Card(code: firstCard["code"] as! String, suit: firstCard["suit"] as! String, image: firstCard["image"] as! String)
                    
                    DispatchQueue.main.async {
                        completion(card)
                    }
                } catch {
                    print("Error in downloadDeck " + error.localizedDescription)
                }
            }
        }
    }
    
    public func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void) {
        
        DispatchQueue.global().async {
            if let url = URL(string: card.image) {
                do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        completion(image!)
                    }
                } catch {
                    print("Error in downloadCardImage " + error.localizedDescription)
                }
            }
        }
    }


    
}
