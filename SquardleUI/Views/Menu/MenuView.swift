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
    @State var showContent = false
    
    var body: some View {
        ZStack {
            ThemeModel.main.backgroundColor
            
            VStack (spacing: 0){
                if showContent{
                    Spacer()
                }
                
                Image("logo")
//                    .animation(.spring(), value: showContent)
                
                if showContent{
                    Spacer()
                    buttons
                    Spacer()
                }
                
            }
        }
        .tint(.black)
        .ignoresSafeArea()
        .environmentObject(stats)
        .onAppear{
            withAnimation(.easeInOut(duration: 1).delay(0.5)){
                showContent = true
            }
        }
    }
    
    var buttons: some View {
        VStack{
            
            if stats.hasActiveGame, FileManager.saveExists() {
                MenuButton(title: "Продолжить") {
                    changeOption(.continueGame)
                }
            }
            
            MenuButton(title: "Новая Игра"){
                changeOption(.newGame)
            }
            
            MenuButton(title: "Статистика"){
                changeOption(.stats)
            }
            
            MenuButton(title: "Как играть?"){
                changeOption(.rules)
            }
        }
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
