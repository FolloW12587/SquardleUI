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
    
//    static func saveGame(save: GameSave) {
//        do {
//            let data = try JSONEncoder().encode(save)
//            try data.write(to: self.gameSaveUrl, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save the game. \(error.localizedDescription)")
//        }
//    }
    
    static func saveExists() -> Bool {
        return self.default.fileExists(atPath: gameSaveUrl.path)
    }
    
//    static func getGameSave() -> GameSave? {
//        do {
//            return try JSONDecoder().decode(GameSave.self, from: .init(contentsOf: gameSaveUrl))
//        } catch {
//            print("\(error.localizedDescription)")
//            return nil
//        }
//    }
    
    static func deleteSave() {
        do {
            try self.default.removeItem(at: gameSaveUrl)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
