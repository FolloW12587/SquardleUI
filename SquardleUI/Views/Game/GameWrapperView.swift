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
    
    init(useSaved: Bool, dismissAction: @escaping () -> ()) {
        _gameLoader = StateObject(wrappedValue: GameLoader(useSaved: useSaved))
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
        .onAppear{
            if !useSaved && stats.hasActiveGame && FileManager.saveExists() {
                print("Starting new game when one exists!")
                Task{
                    stats.gameLost()
                }
            }
        }
    }
}

struct GameWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        GameWrapperView(useSaved: true){}
            .environmentObject(StatsModel())
    }
}
