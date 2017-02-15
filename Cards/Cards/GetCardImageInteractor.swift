//
//  GetCardImageInteractor.swift
//  Cards
//
//  Created by Diego Freniche Brito on 15/2/17.
//  Copyright © 2017 freniche. All rights reserved.
//

import UIKit

public class GetCardImageInteractor {
    let card: Card
    
    public init(card: Card) {
        self.card = card
    }
    
    public func execute(completion: @escaping (UIImage) -> Void) {
        DeckOfCardsAPIManager().downloadCardImage(card: self.card) { (image: UIImage) in
            
            completion(image)
        }
    }
    
    
}
