//
//  ContentView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var stats = StatsModel()
    
    var body: some View {
        ZStack {
            ThemeModel.main.backgroundColor
            
            NavigationView {
                VStack (spacing: 20){
                    if stats.hasActiveGame {
                        MenuButton(title: "Продолжить") {
                            EmptyView()
                        }
                        
                    }
                    
                    MenuButton(title: "Новая Игра"){
                        GameView()
                            .navigationBarBackButtonHidden(true)
                    }
                    
                    MenuButton(title: "Как играть?"){
                        RulesView()
                            .navigationTitle("Правила игры")
                    }
                    
                    MenuButton(title: "Настройки"){
                        EmptyView()
                    }
                    
                }
            }
        }
        .ignoresSafeArea()
        .environmentObject(stats)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
