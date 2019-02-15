//
//  Concentration.swift
//  Concentration
//
//  Created by Jabari.Dash on 2/13/19.
//  Copyright © 2019 Jabari.Dash. All rights reserved.
//

import Foundation

class Concentration {
    
    let maxScore:  Int
    private(set) var gameOver:  Bool
    private(set) var flipCount: Int
    private(set) var score:     Int
    private(set) var cards = [Card]()
    
    /**
     * Computed value that indicates the location index of
     * the only card that is face up at the time that this
     * variable is accessed. If more than one card is face
     * up, or zero cards are face up, then nil is returned.
     */
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        
        get {
            var foundIndex: Int?
            
            for index in cards.indices {
                if cards[index].isFaceUp {
                    
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        
        set(newValue) {
            
            for index in cards.indices {
                
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    /**
     * Increments the number of flips.
     */
    func incrementFlipCount() {
        
        flipCount += 1
    }

    /**
     * Contains the core game logic of Concentration.
     * This function is fired every time a card is
     * selected.
     */
    func chooseCard(at index: Int) {
        
        assert(index >= 0 && index < cards.count, "Concentration.chooseCard(at: \(index): Chosen index out of bounds [0, \(cards.count)")
        
        if gameOver {
            return
        }
        
        // Only do something if the card
        // is unmatched. Otherwise, we ignore the touch
        if !cards[index].isMatched {
            
            // Case 1: One card is already face up, and
            // we are checking to see if this second card
            // is different from the existing face up card
            // and if they match or not
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched      = true
                    
                    score   += 1
                    gameOver = (score == maxScore)
                }
                                
                cards[index].isFaceUp = true
                
            } else {
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    /**
     * Initializes the game by creating a
     * specified number of cards, appending
     * them to the card list, and shuffling them.
     */
    init(numberOfPairsOfCards: Int) {
        
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(0)): Number of pairs of cards must be at least 1")
        
        self.maxScore  = numberOfPairsOfCards
        self.gameOver  = false
        self.flipCount = 0
        self.score     = 0

        for _ in 1...numberOfPairsOfCards {

            let card = Card()

            cards.append(card)
            cards.append(card)
        }

        cards.shuffle()
    }
}
