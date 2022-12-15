//
//  MenuView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 15.12.2022.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var stats: StatsModel
    var hasGameSave: Bool {
        stats.hasActiveGame && FileManager.saveExists()
    }
    @Binding var option: ContentView.MenuOptions
    
    var body: some View {
        ZStack {
            ThemeModel.main.backgroundColor
            
            VStack (spacing: 20){
                if stats.hasActiveGame, FileManager.saveExists() {
                    MenuButton(title: "Продолжить") {
                        changeOption(.continueGame)
                    }
                }
                
                MenuButton(title: "Новая Игра"){
                    changeOption(.newGame)
                }
                
                MenuButton(title: "Как играть?"){
                    changeOption(.rules)
                }
                
                MenuButton(title: "Статистика"){
                    changeOption(.stats)
                }
                
            }
        }
        .tint(.black)
        .ignoresSafeArea()
        .environmentObject(stats)
    }
    
    func changeOption(_ newOption: ContentView.MenuOptions) {
        withAnimation{
            option = newOption
        }
        playSound(SoundMatcher.keyPressed.rawValue)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(option: .constant(.none))
            .environmentObject(StatsModel())
    }
}
