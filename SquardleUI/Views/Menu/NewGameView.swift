//
//  NewGameView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.02.2023.
//

import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var stats: StatsModel
    @EnvironmentObject var theme: ThemeModel
    @State var showGame: Bool
    @State var showAlert: Bool
    @State var selectedGameMode: GameModel.GameMode? = nil
    var dismissAction: () -> ()
    
    var body: some View {
        ZStack{
            theme.backgroundColor
                .ignoresSafeArea()
            
            if showGame {
                if let selectedGameMode {
                    GameWrapperView(useSaved: false, gameMode: selectedGameMode, dismissAction: dismissAction)
                } else {
                    VStack(spacing: 40){
                        Text("Уровень сложности")
                        
                        MenuButton(title: "Нормальная") {
                            selectedGameMode = .normal
                        }
                        
                        MenuButton(title: "Сложная") {
                            selectedGameMode = .hard
                        }
                    }
                }
                
            }
        }
        .alert("Если Вы начнете новую игру, Вам будет засчитано поражение.", isPresented: $showAlert) {
            Button("Новая игра", role: .cancel) {
                showGame = true
                Task{
                    print("Starting new game when one exists!")
                    stats.gameLost()
                }
            }
            Button("Отменить", role: .destructive, action: dismissAction)
        }
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(showGame: true, showAlert: false){}
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
