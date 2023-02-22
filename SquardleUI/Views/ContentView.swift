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
    @Environment(\.colorScheme) var colorScheme
    @StateObject var theme = ThemeModel()
    @State var menuOption: MenuOptions = .none
    
    var body: some View {
        ZStack{
            
            switch menuOption {
            case .none:
                MenuView(option: $menuOption)
            case .continueGame:
                GameWrapperView(useSaved: true, gameMode: stats.gameMode ?? .normal, dismissAction: dismissOption)
            case .newGame:
//                GameWrapperView(useSaved: false, dismissAction: dismissOption)
                NewGameView(showGame: !stats.hasActiveGame, showAlert: stats.hasActiveGame, dismissAction: dismissOption)
            case .rules:
                RulesView(showHeader: true, dismissAction: dismissOption)
            case .stats:
                GameStatsView(dismissAction: dismissOption)
            }
        }
        .tint(Color.primary)
        .onAppear{
            theme.switchTheme(scheme: colorScheme)
        }
        .id(colorScheme)
        .overlay{
            if !stats.didLaunchBefore{
                TutorialView(dismissClosure: stats.firstLaunch)
            }
        }
        .environmentObject(stats)
        .environmentObject(theme)
    }
    
    func dismissOption() {
        withAnimation{
            menuOption = .none
        }
        playSound(SoundMatcher.keyPressed.rawValue)
    }
}

extension ContentView {
    enum MenuOptions {
        case continueGame
        case newGame
        case rules
        case stats
        case none
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
