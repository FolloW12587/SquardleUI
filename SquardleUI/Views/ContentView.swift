//
//  ContentView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI
let dictionary = DictionaryModel()

struct ContentView: View {
    @StateObject var stats = StatsModel()
    
    var body: some View {
        ZStack {
            ThemeModel.main.backgroundColor
            
            NavigationView {
                VStack (spacing: 20){
                    if stats.hasActiveGame, FileManager.saveExists() {
                        MenuButton(title: "Продолжить") {
                            GameWrapperView(useSaved: true)
                                .navigationBarBackButtonHidden(true)
                        }
                        
                    }
                    
                    MenuButton(title: "Новая Игра"){
                        GameWrapperView(useSaved: false)
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
