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
    
    init(useSaved: Bool, gameMode: GameModel.GameMode, dismissAction: @escaping () -> ()) {
        _gameLoader = StateObject(wrappedValue: GameLoader(useSaved: useSaved, gameMode: gameMode))
        self.useSaved = useSaved
        self.dismissAction = dismissAction
    }
    
    var body: some View {
        ZStack{
            if let gameModel = gameLoader.gameModel {
                GameView(gameModel: gameModel, dismissClosure: dismissAction) { gameLoader.newGame()
                }
            } else {
                Color.init(white: 0.6, opacity: 0.8)
                    .ignoresSafeArea()
                
                ProgressView()
            }
        }
    }
}

struct GameWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        GameWrapperView(useSaved: true, gameMode: .normal){}
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
