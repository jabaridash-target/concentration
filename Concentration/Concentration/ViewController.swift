//
//  ViewController.swift
//  Concentration
//
//  Created by Jabari.Dash on 2/13/19.
//  Copyright © 2019 Jabari.Dash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game:  Concentration!
    private var theme: Theme!
    private var emoji: Dictionary<Int, String>!
    
    private var numberOfPairsOfCards: Int {
        
        get {
            
            return (cardButtons.count + 1) / 2
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel:     UILabel!
    @IBOutlet private weak var themePicker:    UIPickerView!
    @IBOutlet private var cardButtons:         [UIButton]!
    
//---------------------------------------------------------------------------------------
    
    /**
     * Resets the view and the game
     */
    @IBAction private func reset() {
    
        game  = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        theme = Theme.themes[1]
        emoji = Dictionary<Int, String>()
        
        for index in game.cards.indices {
            
            setCardFaceDown(by: index)
        }
        
        updateFlipCountLabel(to: game.flipCount)
        updateScoreLabel(to: game.score)
    }
    
//---------------------------------------------------------------------------------------
    
    /**
     * Each card button is tied to this function.
     * When the card is touched, we flip is over.
     */
    @IBAction private func touchCard(_ sender: UIButton) {

        let cardNumber = cardButtons.index(of: sender)!
        
        game.chooseCard(at: cardNumber)
        
        if !game.cards[cardNumber].isMatched {
            game.incrementFlipCount()
            updateFlipCountLabel(to: game.flipCount)
        }
        
        updateScoreLabel(to: game.score)
        
        for index in cardButtons.indices {
            
            if game.cards[index].isFaceUp {
                
                setCardFaceUp(by: index)
            } else {
                
                setCardFaceDown(by: index)
            }
        }
        
        if game.gameOver {
            
            alert(
                message: theme.gameOverMessage,
                title:   "You win!",
                then: {[weak self] in
                    self?.reset()
                }
            )
        }
    }
    
//---------------------------------------------------------------------------------------
    
    /**
     * Flips a card face up to reveal
     * the underlying emoji.
     */
    private func setCardFaceUp(by index: Int) {
        
        let card   = game.cards[index]
        let button = cardButtons[index]
        let emoji  = getEmoji(for: card)
        
        button.setTitle(emoji, for: UIControl.State.normal)
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : theme.faceUpColor
    }

//---------------------------------------------------------------------------------------
    
    /**
     * Flips a card face down to hide
     * the underlying emoji.
     */
    private func setCardFaceDown(by index: Int) {
        
        let card   = game.cards[index]
        let button = cardButtons[index]
        
        button.setTitle("", for: UIControl.State.normal)
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : theme.faceDownColor
    }
    
//---------------------------------------------------------------------------------------
    
    /**
     * Updates the number of flips in the view
     */
    private func updateFlipCountLabel(to value: Int) {
    
        flipCountLabel.text = "Flips: \(value)"
    }
    
//---------------------------------------------------------------------------------------
    
    /**
     * Updates the score value in the view
     */
    private func updateScoreLabel(to value: Int) {
        
        scoreLabel.text = "Score: \(value)"
    }
    
//---------------------------------------------------------------------------------------
    
    /**
     * Fetches the corresponding emoji
     * of the specified card.
     */
    private func getEmoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil && theme.emojiChoices.count > 0 {
            
            let index = theme.emojiChoices.count.arc4random
            
            emoji[card.identifier] = theme.emojiChoices.remove(at: index)
        }
        
        return emoji[card.identifier] ?? "?"
    }

//---------------------------------------------------------------------------------------
    
    private func alert(message: String, title: String = "", then callback: @escaping () -> Void) {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { (action: UIAlertAction) in
                callback()
            }
        )
        
        controller.addAction(action)
        
        self.present(controller, animated: true, completion: nil)
    }
    
//---------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        
        reset()
    }

//---------------------------------------------------------------------------------------
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
}

extension Int {
    
    /**
     * Returns a random integer between 0 and itself (exclusive).
     * If this integer is 0, then 0 is returned. 
     */
    var arc4random: Int {
        
        if self == 0 {
            
            return self
        } else {
            
            let absoluteValue     = abs(self)
            let unsigned32BitInt  = UInt32(absoluteValue)
            let randomUnsignedInt = arc4random_uniform(unsigned32BitInt)
            
            let random = Int(randomUnsignedInt)
            
            return self > 0 ? random : -random
        }
    }
}
