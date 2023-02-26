//
//  StatsModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


class StatsModel: ObservableObject {
    @Published var didLaunchBefore: Bool
    @Published var hasActiveGame: Bool {
        didSet {
            if !hasActiveGame {
                FileManager.deleteSave()
                activeGameMode = nil
            }
        }
    }
    var activeGameMode: String?
    var gameMode: GameModel.GameMode? {
        get {
            if activeGameMode == "hard" { return .hard }
            if activeGameMode == "normal" { return .normal }
            return nil
        }
        set {
            if newValue == .normal {
                activeGameMode = "normal"
                return
            }
            
            if newValue == .hard {
                activeGameMode = "hard"
                return
            }
            
            activeGameMode = nil
        }
    }
    
    var totalWins: Int
    var totalGames: Int
    var totalLoses: Int {
        totalGames - totalWins
    }
    var currentStreak: Int {
        didSet {
            updateStreaks()
            updateBestStreak()
        }
    }
    var bestStreak: Int
    var streaks: [Int]
    
    var winRate: Float {
        if totalGames == 0 {
            return 0
        }
        return Float(totalWins) / Float(totalGames)
    }
    var loseRate: Float {
        if totalGames == 0 {
            return 0
        }
        return Float(totalLoses) / Float(totalGames)
    }
    
    init(){
        let defaults = UserDefaults.standard
        
        didLaunchBefore = defaults.bool(forKey: "didLaunchBefore")
        hasActiveGame = defaults.bool(forKey: "hasActiveGame")
        totalWins = defaults.integer(forKey: "totalWins")
        totalGames = defaults.integer(forKey: "totalGames")
        currentStreak = defaults.integer(forKey: "currentStreak")
        bestStreak = defaults.integer(forKey: "bestStreak")
        streaks = defaults.array(forKey: "streaks") as? [Int] ?? []
        activeGameMode = defaults.string(forKey: "activeGameMode")
    }
    
    init(didLaunchBefore: Bool, hasActiveGame: Bool, activeGameMode: String?, totalWins: Int, totalGames: Int, currentStreak: Int, bestStreak: Int, streaks: [Int]) {
        self.didLaunchBefore = didLaunchBefore
        self.hasActiveGame = hasActiveGame
        self.activeGameMode = activeGameMode
        self.totalWins = totalWins
        self.totalGames = totalGames
        self.currentStreak = currentStreak
        self.bestStreak = bestStreak
        self.streaks = streaks
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        defaults.set(didLaunchBefore, forKey: "didLaunchBefore")
        defaults.set(hasActiveGame, forKey: "hasActiveGame")
        defaults.set(totalWins, forKey: "totalWins")
        defaults.set(totalGames, forKey: "totalGames")
        defaults.set(currentStreak, forKey: "currentStreak")
        defaults.set(bestStreak, forKey: "bestStreak")
        defaults.set(streaks, forKey: "streaks")
        defaults.set(activeGameMode, forKey: "activeGameMode")
    }
    
    func gameWon() {
        hasActiveGame = false
        
        totalGames += 1
        totalWins += 1
        currentStreak += 1
        
        save()
    }
    
    func gameLost() {
        hasActiveGame = false
        
        totalGames += 1
        currentStreak = 0
        
        save()
    }
    
    func firstLaunch() {
        didLaunchBefore = true
        save()
    }
    
    func reset() {
        hasActiveGame = false
        totalWins = 0
        totalGames = 0
        currentStreak = 0
        bestStreak = 0
        streaks = []
        gameMode = nil
        
        save()
    }
    
    private func newStreak(){
        streaks.append(1)
        if streaks.count > 10 {
            streaks.removeFirst()
        }
    }
    
    private func updateLastStreak(){
        let _ = streaks.popLast()
        streaks.append(currentStreak)
    }
    
    private func updateStreaks(){
        switch currentStreak {
        case 0:
            return
        case 1:
            newStreak()
        default:
            updateLastStreak()
        }
    }
    
    private func updateBestStreak() {
        if currentStreak > bestStreak {
            bestStreak = currentStreak
        }
    }
}

extension StatsModel{
    static var testStats = StatsModel(
        didLaunchBefore: true,
        hasActiveGame: true,
        activeGameMode: "normal",
        totalWins: 38,
        totalGames: 47,
        currentStreak: 2,
        bestStreak: 7,
        streaks: [4,1,4,3,6,7,2,4,2]
    )
}
