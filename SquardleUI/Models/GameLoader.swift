//
//  GameLoader.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 06.12.2022.
//

import Foundation

class GameLoader: ObservableObject {
    @Published var gameModel: GameModel? = nil
    var gameMode: GameModel.GameMode
    
    init(useSaved: Bool = false, gameMode: GameModel.GameMode = .normal) {
        self.gameMode = gameMode
        Task {
            if useSaved, FileManager.saveExists(), let gameModel = FileManager.getSavedGame() {
                DispatchQueue.main.async {
                    self.gameModel = gameModel
                }
            } else {
                let gameModel = GameModel(mode: gameMode)
                DispatchQueue.main.async {
                    self.gameModel = gameModel
                }
            }
        }
    }
    
    func newGame() {
        self.gameModel = nil
        Task {
            let gameModel = GameModel(mode: gameMode)
            DispatchQueue.main.async {
                self.gameModel = gameModel
            }
        }
    }
}
