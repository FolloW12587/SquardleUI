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
    @StateObject var settings: GameSettings = GameSettings()
    @State var menuOption: MenuOptions = .none
    var lastGamePlayed = LastGamePlayed(words: [], guessesUsed: 0, gameMode: .normal)
    var boardEndModel = BoardEndModel(tiles: [])
    
    var hasActiveGame: Bool {
        return stats.hasActiveGame && FileManager.saveExists() && FileManager.getSavedGame() != nil
    }
    
    var body: some View {
        ZStack{
            
            switch menuOption {
            case .none:
                MenuView(option: $menuOption)
            case .continueGame:
                GameWrapperView(useSaved: true, gameMode: stats.gameMode ?? .normal, dismissAction: dismissOption, gameWonAction: gameWonAction, gameLostAction: gameLostOption)
            case .newGame:
                NewGameView(showGame: !hasActiveGame, showAlert: hasActiveGame, dismissAction: dismissOption, newGameAction: newGameOption)
            case .rules:
                RulesView(showHeader: true, dismissAction: dismissOption)
            case .stats:
                GameStatsView(dismissAction: dismissOption)
            case .gameWonView:
                EndView(lastGamePlayed: lastGamePlayed, homeAction: dismissOption, statsAction: statsOption)
            case .gameLostView:
                GameLostView(boardModel: boardEndModel, homeAction: dismissOption, newGameAction: showGameModeSelection, statsAction: statsOption)
            case .settings:
                SettingsView(dismissAction: dismissOption)
            }
        }
        .tint(Color.primary)
        .onAppear{
            theme.switchTheme(scheme: colorScheme)
        }
        .overlay{
            if !stats.didLaunchBefore{
                TutorialView(dismissClosure: stats.firstLaunch)
            }
        }
        .environmentObject(stats)
        .environmentObject(theme)
        .environmentObject(settings)
        .preferredColorScheme(settings.preferedColorScheme)
        .onChange(of: colorScheme) { newValue in
            withAnimation {
                theme.switchTheme(scheme: newValue)
            }
        }
    }
    
    func dismissOption() {
        withAnimation{
            menuOption = .none
        }
        TactileResponse.shared.makeResponse(feedbackStyle: .medium, systemSoundID: SoundMatcher.keyPressed.rawValue)
    }
    
    func statsOption() {
        withAnimation{
            menuOption = .stats
        }
        TactileResponse.shared.makeResponse(feedbackStyle: .medium, systemSoundID: SoundMatcher.keyPressed.rawValue)
    }
    
    func newGameOption() {
        withAnimation{
            menuOption = .continueGame
        }
        TactileResponse.shared.makeResponse(feedbackStyle: .medium, systemSoundID: SoundMatcher.keyPressed.rawValue)
    }
    
    func showGameModeSelection() {
        withAnimation {
            menuOption = .newGame
        }
    }
    
    func gameWonAction(_ lastGamePlayed: LastGamePlayed) {
        self.lastGamePlayed.words = lastGamePlayed.words
        self.lastGamePlayed.gameMode = lastGamePlayed.gameMode
        self.lastGamePlayed.guessesUsed = lastGamePlayed.guessesUsed
        withAnimation {
            menuOption = .gameWonView
        }
    }
    
    func gameLostOption(_ tiles: [TileModel]) {
        boardEndModel.tiles = tiles
        withAnimation {
            menuOption = .gameLostView
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
        case gameLostView
        case settings
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
