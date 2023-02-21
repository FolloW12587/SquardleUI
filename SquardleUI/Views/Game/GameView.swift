//
//  GameView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameModel: GameModel
    @EnvironmentObject var stats: StatsModel
    @EnvironmentObject var theme: ThemeModel
    
    var dismissClosure: () -> ()
    var restartClosure: () -> ()
    
    var body: some View {
        ZStack {
            theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                HeaderView(guiModel: gameModel.guiModel, dismissAction: dismissClosure)
                Spacer()
                BoardView(boardModel: gameModel.board)
                Spacer()
                KeyboardView(keyboardModel: gameModel.keyboard)
                
                SubmitButtonView(guiModel: gameModel.guiModel, title: "ВВОД", action: gameModel.submitWord)
                .padding(.horizontal, 10)
            }
            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
            
            if gameModel.isGameOver || gameModel.isGameWon {
                GameEndView(isGameWon: gameModel.isGameWon) {
                    dismissClosure()
                } statsAction: {
                    gameModel.guiModel.areStatsPresented.toggle()
                } restartAction: {
                    restartClosure()
                }
                .onAppear(perform: gameEnded)
            }
            
        }
        .onAppear(perform: gameStarted)
        .environmentObject(gameModel)
        .id(gameModel.id)
        .overlay {
            if gameModel.showAdd {
                YandexInterstitial(){
                    DispatchQueue.main.async {
                        gameModel.showAdd = false
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    func gameStarted() {
        Task {
            print("Board appeared")
            FileManager.saveGame(gameModel)
            stats.hasActiveGame = true
            stats.save()
        }
    }
    
    func gameEnded() {
        Task {
            if gameModel.isGameWon {
                stats.gameWon()
            } else {
                stats.gameLost()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameModel: GameModel()){} restartClosure: {}
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
