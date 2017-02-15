//
//  Card.swift
//  Cards
//
//  Created by Jose Sanchez Rodriguez on 14/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import Foundation

public class Card {
    let code: String
    let suit: String
    let image: String
    
    init(code: String, suit: String, image: String) {
        self.code = code
        self.suit = suit
        self.image = image
    }
}
