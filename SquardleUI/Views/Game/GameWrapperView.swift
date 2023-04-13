//
//  GameWrapperView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 06.12.2022.
//

import SwiftUI

struct GameWrapperView: View {
    @EnvironmentObject var stats: StatsModel

    @StateObject var gameLoader: GameLoader
    let useSaved: Bool
    var dismissAction: () -> ()
    var gameWonAction: (LastGamePlayed) -> ()
    var gameLostAction: ([TileModel]) -> ()
    
    init(useSaved: Bool, gameMode: GameModel.GameMode, dismissAction: @escaping () -> (), gameWonAction: @escaping (LastGamePlayed) -> (), gameLostAction: @escaping ([TileModel]) -> ()) {
        _gameLoader = StateObject(wrappedValue: GameLoader(useSaved: useSaved, gameMode: gameMode))
        self.useSaved = useSaved
        self.dismissAction = dismissAction
        self.gameWonAction = gameWonAction
        self.gameLostAction = gameLostAction
    }
    
    var body: some View {
        ZStack{
            if let gameModel = gameLoader.gameModel {
                GameView(gameModel: gameModel, dismissClosure: dismissAction, gameWonClosure: gameWonAction, gameLostClosure: gameLostAction)
            } else {
                Color.init(white: 0.6, opacity: 0.8)
                    .ignoresSafeArea()
                
                ProgressView()
            }
        }
    }
    
    func restartAction() {
        stats.hasActiveGame = true
        gameLoader.newGame()
    }
}

struct GameWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        GameWrapperView(useSaved: true, gameMode: .normal){} gameWonAction: { _ in } gameLostAction: { _ in }
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
