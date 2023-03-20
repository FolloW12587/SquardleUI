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
    var gameWonClosure: (LastGamePlayed) -> ()
    
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
                if gameModel.isGameOver {
                    VStack {
                        if gameModel.showSolution {
                            Spacer()
                        }
                    
                        GameEndView() {
                            dismissClosure()
                        } statsAction: {
                            gameModel.guiModel.areStatsPresented.toggle()
                        } restartAction: {
                            restartClosure()
                        } showSolutionAction: {
                            gameModel.showSolution = true
                        }
                        .animation(.easeInOut(duration: 0.5), value: gameModel.showSolution)
                    }
                } else if gameModel.isGameWon {
                    Circle()
                        .fill(.clear)
                        .onAppear{
                            gameWonClosure(LastGamePlayed(words: gameModel.words, guessesUsed: gameModel.guessesUsed, gameMode: gameModel.mode))
                        }
//                    EndView(words: gameModel.words, guessesUsed: gameModel.guessesUsed, gameMode: gameModel.mode) {
//                        dismissClosure()
//                    } statsAction: {
//                        gameModel.guiModel.areStatsPresented.toggle()
//                    }

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
        .overlay {
            if gameModel.showPreEndView {
                PreEndView {
                    DispatchQueue.main.async {
                        gameModel.usedRewardAdd = true
                        gameModel.showPreEndView = false
                    }
                } rewardClosure: {
                    DispatchQueue.main.async {
                        gameModel.guessesLeft += 1
                    }
                }
            }
        }
        .onAppear {
            gameModel.stats = stats
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameModel: GameModel(mode: .normal)){} restartClosure: {} gameWonClosure: { _ in }
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
