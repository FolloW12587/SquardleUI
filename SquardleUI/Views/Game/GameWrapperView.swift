//
//  GameWrapperView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 06.12.2022.
//

import SwiftUI

struct GameWrapperView: View {
    @EnvironmentObject var stats: StatsModel
    @Environment(\.presentationMode) var presentationMode

    @StateObject var gameLoader: GameLoader
    
    init(useSaved: Bool) {
        _gameLoader = StateObject(wrappedValue: GameLoader(useSaved: useSaved))
    }
    
    var body: some View {
        ZStack{
            if let gameModel = gameLoader.gameModel {
                GameView(gameModel: gameModel){
                    presentationMode.wrappedValue.dismiss()
                } restartClosure: {
                    gameLoader.newGame()
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
        GameWrapperView(useSaved: true)
            .environmentObject(StatsModel())
    }
}
