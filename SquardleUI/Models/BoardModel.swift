//
//  BoardModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


class BoardModel: Codable {
    var tiles = [TileModel]()
    
    init(words: [String]) {
        createTiles(words: words)
    }
    
    static let example = BoardModel(words: ["КОРМА", "БАТЫР", "НОРКА", "КАБАН", "РОТОР", "АОРТА"])
    
    func createTiles(words: [String]){
        for i in 0..<3 {
            let word = words[i]
            let y = i * 2
            for (x, character) in word.enumerated() {
                tiles.append(createTile(character: character, at: CGPoint(x: x, y: y)))
            }
        }
        
        for i in 3..<6 {
            let word = words[i]
            let x = (i - 3) * 2
            tiles.append(createTile(character: word.getChar(at: 1)!, at: CGPoint(x: x, y: 1)))
            tiles.append(createTile(character: word.getChar(at: 3)!, at: CGPoint(x: x, y: 3)))
        }
    }
    
    func createTile(character: Character, at position: CGPoint) -> TileModel {
        return TileModel(character: character, position: position)
    }
    
    func getTile(at position: CGPoint) -> TileModel? {
        return tiles.filter { $0.position == position }.first
    }
    
    func getTilesOnGuessingWay(index: Int) -> [TileModel] {
        return tiles.filter{ $0.position.x == CGFloat(index) || $0.position.y == CGFloat(index) }
    }
    
    func getOpenedWordsCount() -> Int {
        var inc = 0
        for i in stride(from: 0, through: 5, by: 2) {
            var opened = true
            for j in 0..<5 {
                if let tile = getTile(at: CGPoint(x: i, y: j)), !tile.isOpened {
                    opened = false
                    break
                }
            }
            
            if opened {
                inc += 1
            }
            
            opened = true
            for j in 0..<5 {
                if let tile = getTile(at: CGPoint(x: j, y: i)), !tile.isOpened {
                    opened = false
                    break
                }
            }
            
            if opened {
                inc += 1
            }
        }
        
        return inc
    }
    
    func isSolved() -> Bool {
        return tiles.reduce(true) { partialResult, tile in
            tile.isOpened && partialResult
        }
    }
}
