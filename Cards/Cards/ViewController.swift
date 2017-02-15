//
//  ViewController.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez on 14/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardImageView: UIImageView!
    
    var deck: Deck!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paintCardPlaceholder()
    }
    
    @IBAction func deckButtonClicked(_ sender: Any) {
        DeckInteractor(manager: DeckOfCardsAPIManagerNSURLSessionImpl()).execute { (deck: Deck) in
            print("DeckId is: " + deck.deckId)
            self.deck = deck
        }
    }
    
    @IBAction func cardButtonClicked(_ sender: Any) {
        self.paintCardPlaceholder()

        GetCardFromDeckInteractor(deck: self.deck, manager: DeckOfCardsAPIManagerNSOperationQueueImpl()).execute { (card) in
            print("Card is: " + card.image)
            
            GetCardImageInteractor(card: card).execute(completion: { (image: UIImage) in
                self.cardImageView.image = image
            })
        }
    }
    
    func paintCardPlaceholder() {
        assert(Thread.current == Thread.main)
        
        self.cardImageView.image = UIImage(named: "card")
    }
}

