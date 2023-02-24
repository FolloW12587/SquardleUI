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
    @State var showHintAlert: Bool = false
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
                    VStack{
                        MenuButton(title: "Нормальная") {
                            selectedGameMode = .normal
                        }
                        .padding(.bottom)
                        VStack(alignment: .trailing){
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(Color.primary)
                        }
                        .frame(width: 200, alignment: .trailing)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showHintAlert = true
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
        .alert("В сложной игре вам дается 7 попыток вместо 9, а также могут попадаться более редкие слова.", isPresented: $showHintAlert){}
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(showGame: true, showAlert: false){}
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
