//
//  FileManager - extensions.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


extension FileManager {
    static let gameSaveUrl = FileManager.getDocumentsDirectory().appendingPathComponent("gamesave")
    
    static func getDocumentsDirectory() -> URL {
        self.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func saveGame(_ game: GameModel) {
        do {
            let data = try JSONEncoder().encode(game)
            try data.write(to: self.gameSaveUrl, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save the game. \(error.localizedDescription)")
        }
    }
    
    static func saveExists() -> Bool {
        return self.default.fileExists(atPath: gameSaveUrl.path)
    }
    
    static func getSavedGame() -> GameModel? {
        do {
            return try JSONDecoder().decode(GameModel.self, from: .init(contentsOf: gameSaveUrl))
        } catch {
            print("\(error.localizedDescription)")
            return nil
        }
    }
    
    static func deleteSave() {
        do {
            try self.default.removeItem(at: gameSaveUrl)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
