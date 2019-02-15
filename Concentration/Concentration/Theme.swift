//
//  Theme.swift
//  Concentration
//
//  Created by Jabari.Dash on 2/13/19.
//  Copyright © 2019 Jabari.Dash. All rights reserved.
//

import Foundation
import UIKit.UIColor

struct Theme {
    
    let name:            String
    var emojiChoices:    Array<String>
    let faceUpColor:     UIColor
    let faceDownColor:   UIColor
    let gameOverMessage: String
    
    static let themes = [
        Theme(
            name: "Halloween",
            emojiChoices: ["🦇", "😱", "🙀", "😈", "🎃", "🍭", "🍬", "🍎"],
            faceUpColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            faceDownColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),
            gameOverMessage: "Trick of Treat!"
        ),
        Theme(
            name: "Valentine's Day",
            emojiChoices: ["💌", "❤️", "💕", "🌹", "🌸 ", "💑", "🍫", "🥰"],
            faceUpColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
            faceDownColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),
            gameOverMessage: "Happy Valentine's Day!\n\n~Con amor ❤️,\n\nJabari"
        )
    ]
}
