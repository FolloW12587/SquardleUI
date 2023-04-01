//
//  MenuView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 15.12.2022.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var stats: StatsModel
    @EnvironmentObject var theme: ThemeModel
    var hasGameSave: Bool {
        stats.hasActiveGame && FileManager.saveExists()
    }
    @Binding var option: ContentView.MenuOptions
    @State var showContent = false
    
    var body: some View {
        ZStack {
            theme.backgroundColor
                .ignoresSafeArea()
            
            settings
            
            VStack (spacing: 0){
                if showContent{
                    Spacer()
                }
                
                Image("logo")
                
                if showContent{
                    Spacer()
                    buttons
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .tint(Color.primary)
        .environmentObject(stats)
        .onAppear{
            withAnimation(.easeInOut(duration: 1).delay(0.5)){
                showContent = true
            }
        }
    }
    
    var settings: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    changeOption(.settings)
                } label: {
                    Image(systemName: "gearshape.circle")
                        .foregroundColor(Color.primary)
                        .font(.system(size: 30))
                }

            }
            .padding()
            Spacer()
        }
    }
    
    var buttons: some View {
        VStack{
            if stats.hasActiveGame, FileManager.saveExists(), FileManager.getSavedGame() != nil {
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
        TactileResponse.shared.makeResponse(feedbackStyle: .medium, systemSoundID: SoundMatcher.keyPressed.rawValue)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(option: .constant(.none))
            .environmentObject(StatsModel())
            .environmentObject(ThemeModel())
    }
}
