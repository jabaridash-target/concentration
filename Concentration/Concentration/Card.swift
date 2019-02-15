//
//  Card.swift
//  Concentration
//
//  Created by Jabari.Dash on 2/13/19.
//  Copyright © 2019 Jabari.Dash. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp  = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    /**
     * Makes sure that each new card has a unique
     * identifier by incrementing the static id
     * on each function call.
     */
    private static func getUniqueIdentifier() -> Int {
        
        identifierFactory += 1
        
        return identifierFactory
    }
    
    init() {
        
        self.identifier = Card.getUniqueIdentifier()
    }
}
