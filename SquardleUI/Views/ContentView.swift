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
    var lastGamePlayed = LastGamePlayed(words: [], guessesUsed: 0, gameMode: .normal)
    
    var hasActiveGame: Bool {
        return stats.hasActiveGame && FileManager.saveExists() && FileManager.getSavedGame() != nil
    }
    
    var body: some View {
        ZStack{
            
            switch menuOption {
            case .none:
                MenuView(option: $menuOption)
            case .continueGame:
                GameWrapperView(useSaved: true, gameMode: stats.gameMode ?? .normal, dismissAction: dismissOption, gameWonAction: gameWonAction)
            case .newGame:
                NewGameView(showGame: !hasActiveGame, showAlert: hasActiveGame, dismissAction: dismissOption, newGameAction: newGameOption)
            case .rules:
                RulesView(showHeader: true, dismissAction: dismissOption)
            case .stats:
                GameStatsView(dismissAction: dismissOption)
            case .gameWonView:
                EndView(lastGamePlayed: lastGamePlayed, homeAction: dismissOption, statsAction: statsOption)
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
    
    func statsOption() {
        withAnimation{
            menuOption = .stats
        }
        playSound(SoundMatcher.keyPressed.rawValue)
    }
    
    func newGameOption() {
        withAnimation{
            menuOption = .continueGame
        }
        playSound(SoundMatcher.keyPressed.rawValue)
    }
    
    func gameWonAction(_ lastGamePlayed: LastGamePlayed) {
        self.lastGamePlayed.words = lastGamePlayed.words
        self.lastGamePlayed.gameMode = lastGamePlayed.gameMode
        self.lastGamePlayed.guessesUsed = lastGamePlayed.guessesUsed
        withAnimation {
            menuOption = .gameWonView
        }
    }
}

extension ContentView {
    enum MenuOptions {
        case continueGame
        case newGame
        case rules
        case stats
        case none
        case gameWonView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
