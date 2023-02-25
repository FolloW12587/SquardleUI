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
            
            if gameModel.showEndView {
                VStack {
                    if gameModel.showSolution {
                        Spacer()
                    }
                
                    GameEndView(isGameWon: gameModel.isGameWon) {
                        dismissClosure()
                    } statsAction: {
                        gameModel.guiModel.areStatsPresented.toggle()
                    } restartAction: {
                        restartClosure()
                    } showSolutionAction: {
                        gameModel.showSolution = true
                    }
                    .animation(.easeInOut(duration: 1), value: gameModel.showSolution)
                .onAppear(perform: gameEnded)
                }
            }
            
        }
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
        GameView(gameModel: GameModel(mode: .normal)){} restartClosure: {}
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
