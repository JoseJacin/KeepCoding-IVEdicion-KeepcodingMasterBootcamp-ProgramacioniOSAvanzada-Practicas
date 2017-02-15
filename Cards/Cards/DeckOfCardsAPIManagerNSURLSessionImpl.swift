//
//  DeckOfCardsAPIManagerNSURLSessionImpl.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez on 15/2/17.
//  Copyright © 2017 freniche. All rights reserved.
//

import Foundation
import UIKit

public class DeckOfCardsAPIManagerNSURLSessionImpl: DeckOfCardsAPIManager {
    public func downloadDeck(completion: @escaping (Deck) -> Void) {
        // Se invoca a la versión que tiene como segundo argumento una clausura de error
        self.downloadDeck(completion: completion, onError: nil)
    }
    
    // Con el paréntesis se indica que la clausura es opcional
    public func downloadDeck(completion: @escaping (Deck) -> Void, onError: ErrorClosure? = nil) {
        let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        if let url = URL(string: urlString) {
            // Se crea una sesión
            let session = URLSession.shared
            // Se crea una tarea
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                // Se controla si ha ocurrido algún error al realizar la descarga
                if let error = error, let errorClosure = onError {
                    errorClosure(error)
                    return;
                }
                do {
                    if let data = data {
                        let deckJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                        
                        let deck = Deck(deckId: deckJson["deck_id"] as! String)
                        
                        // Se vuelve al hilo principal
                        DispatchQueue.main.async {
                            completion(deck)
                        }
                    }
                } catch {
                    print("Error in downloadDeck " + error.localizedDescription)
                    if let errorClosure = onError {
                        errorClosure(error)
                    }
                }
            })
            // Se ejecuta la tarea para realizar la descarga
            task.resume()
        }
    }
    
    public func downloadCard(deck: Deck, completion: @escaping (Card) -> Void) {
        let urlString = "https://deckofcardsapi.com/api/deck/\( deck.deckId )/draw/?count=1"
        
        // Se asigna todo el código a NSOperationQueue
        let queue = OperationQueue()
        queue.addOperation {
            if let url = URL(string: urlString) {
                do {
                    let data = try Data(contentsOf: url)
                    let cardJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                    
                    let cards = cardJson["cards"] as! [Dictionary<String, Any>]
                    
                    let firstCard = cards[0]
                    
                    let card = Card(code: firstCard["code"] as! String, suit: firstCard["suit"] as! String, image: firstCard["image"] as! String)
                    
                    // Se vuelve al hilo principal
                    OperationQueue.main.addOperation {
                        completion(card)
                    }
                } catch {
                    print("Error in downloadDeck " + error.localizedDescription)
                }
            }
        }
    }
    
    public func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void) {
        
        // Se asigna todo el código a NSOperationQueue
        let queue = OperationQueue()
        queue.addOperation {
            DispatchQueue.global().async {
                if let url = URL(string: card.image) {
                    do {
                        let data = try Data(contentsOf: url)
                        let image = UIImage(data: data)
                        
                        // Se vuelve al hilo principal
                        OperationQueue.main.addOperation {
                            completion(image!)
                        }
                    } catch {
                        print("Error in downloadCardImage " + error.localizedDescription)
                    }
                }
            }
        }
    }
}
