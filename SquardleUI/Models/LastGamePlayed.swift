//
//  LastGamePlayed.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 20.03.2023.
//

import Foundation

class LastGamePlayed {
    var words: [String]
    var guessesUsed: Int
    var gameMode: GameModel.GameMode
    
    init(words: [String], guessesUsed: Int, gameMode: GameModel.GameMode) {
        self.words = words
        self.guessesUsed = guessesUsed
        self.gameMode = gameMode
    }
}
