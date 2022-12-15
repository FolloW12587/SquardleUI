//
//  GameLoader.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 06.12.2022.
//

import Foundation

class GameLoader: ObservableObject {
    @Published var gameModel: GameModel? = nil
    
    init(useSaved: Bool = false) {
        Task {
            if useSaved, FileManager.saveExists(), let gameModel = FileManager.getSavedGame() {
                DispatchQueue.main.async {
                    self.gameModel = gameModel
                }
            } else {
                let gameModel = GameModel()
                DispatchQueue.main.async {
                    self.gameModel = gameModel
                }
            }
        }
    }
    
    func newGame() {
        self.gameModel = nil
        Task {
            let gameModel = GameModel()
            DispatchQueue.main.async {
                self.gameModel = gameModel
            }
        }
    }
}
