//
//  StatsModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


class StatsModel: ObservableObject {
    var isNotFirstLaunch: Bool
    @Published var hasActiveGame: Bool {
        didSet {
            if !hasActiveGame {
                FileManager.deleteSave()
            }
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

        isNotFirstLaunch = defaults.bool(forKey: "isNotFirstLaunch")
        hasActiveGame = defaults.bool(forKey: "hasActiveGame")
        totalWins = defaults.integer(forKey: "totalWins")
        totalGames = defaults.integer(forKey: "totalGames")
        currentStreak = defaults.integer(forKey: "currentStreak")
        bestStreak = defaults.integer(forKey: "bestStreak")
        streaks = defaults.array(forKey: "streaks") as? [Int] ?? []
    }
    
    init(isNotFirstLaunch: Bool, hasActiveGame: Bool, totalWins: Int, totalGames: Int, currentStreak: Int, bestStreak: Int, streaks: [Int]) {
        self.isNotFirstLaunch = isNotFirstLaunch
        self.hasActiveGame = hasActiveGame
        self.totalWins = totalWins
        self.totalGames = totalGames
        self.currentStreak = currentStreak
        self.bestStreak = bestStreak
        self.streaks = streaks
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        defaults.set(isNotFirstLaunch, forKey: "isNotFirstLaunch")
        defaults.set(hasActiveGame, forKey: "hasActiveGame")
        defaults.set(totalWins, forKey: "totalWins")
        defaults.set(totalGames, forKey: "totalGames")
        defaults.set(currentStreak, forKey: "currentStreak")
        defaults.set(bestStreak, forKey: "bestStreak")
        defaults.set(streaks, forKey: "streaks")
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
        isNotFirstLaunch: true,
        hasActiveGame: true,
        totalWins: 7,
        totalGames: 9,
        currentStreak: 2,
        bestStreak: 4,
        streaks: [4,1,2]
    )
}
