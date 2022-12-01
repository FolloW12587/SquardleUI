//
//  StatsModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


class StatsModel: ObservableObject {
    var isNotFirstLaunch: Bool
    var hasActiveGame: Bool {
        didSet {
            if !hasActiveGame {
                FileManager.deleteSave()
            }
        }
    }
    
    var totalWins: Int
    var totalGames: Int
    var currentStreak: Int
    var bestStreak: Int
    var winRate: Float {
        if totalGames == 0 {
            return 0
        }
        return Float(totalWins) / Float(totalGames)
    }
    
    init(){
        let defaults = UserDefaults.standard
        
        isNotFirstLaunch = defaults.bool(forKey: "isNotFirstLaunch")
        hasActiveGame = defaults.bool(forKey: "hasActiveGame")
        totalWins = defaults.integer(forKey: "totalWins")
        totalGames = defaults.integer(forKey: "totalGames")
        currentStreak = defaults.integer(forKey: "currentStreak")
        bestStreak = defaults.integer(forKey: "bestStreak")
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        defaults.set(isNotFirstLaunch, forKey: "isNotFirstLaunch")
        defaults.set(hasActiveGame, forKey: "hasActiveGame")
        defaults.set(totalWins, forKey: "totalWins")
        defaults.set(totalGames, forKey: "totalGames")
        defaults.set(currentStreak, forKey: "currentStreak")
        defaults.set(bestStreak, forKey: "bestStreak")
    }
    
    func gameWon() {
        hasActiveGame = false
        
        totalGames += 1
        totalWins += 1
        currentStreak += 1
        
        if currentStreak > bestStreak {
            bestStreak = currentStreak
        }
        
        save()
    }
    
    func gameLost() {
        hasActiveGame = false
        
        totalGames += 1
        currentStreak = 0
        
        save()
    }
}

