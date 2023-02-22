//
//  NewGameView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.02.2023.
//

import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var stats: StatsModel
    @State var showGame: Bool
    @State var showAlert: Bool
    var dismissAction: () -> ()
    
    var body: some View {
        ZStack{
            if showGame {
                GameWrapperView(useSaved: false, dismissAction: dismissAction)
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
        NewGameView(showGame: false, showAlert: true){}
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
