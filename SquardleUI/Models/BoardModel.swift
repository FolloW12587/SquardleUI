//
//  BoardModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


class BoardModel: ObservableObject, Identifiable, Codable {
    let id: UUID
    var tiles = [TileModel]()
    
    init(words: [String]) {
        id = UUID()
        createTiles(words: words)
        print("BoardModel \(id) created")
    }
    
    deinit {
        print("BoardModel \(id) destroyed")
    }
    
    static let exampleWords = ["КОРМА", "БАТЫР", "НОРКА", "КАБАН", "РОТОР", "АОРТА"]
    static let example = BoardModel(words: BoardModel.exampleWords)
    
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
    
    func showSolution() {
        for tile in tiles {
            tile.showSolution = true
        }
    }
    
    func showEndAnimation() {
        for tile in tiles {
            tile.showEndAnimation.toggle()
        }
    }
    
    func animateWordByIndex(_ index: Int) {
        if index < 3 {
            for j in 0..<5 {
                if let tile = getTile(at: CGPoint(x: j, y: index * 2)){
                    DispatchQueue.main.async {
                        tile.showAnimationInRow = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        tile.showAnimationInRow = false
                    }
                }
            }
            return
        }
        
        for j in 0..<5 {
            if let tile = getTile(at: CGPoint(x: (index - 3) * 2, y: j)){
                DispatchQueue.main.async {
                    tile.showAnimationInColumn = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    tile.showAnimationInColumn = false
                }
            }
        }
    }
    
    func getOpenedWordsIndexes() -> [Int] {
        var wordsIndexes: [Int] = []
        for i in stride(from: 0, through: 5, by: 2) {
            var opened = true
            for j in 0..<5 {
                if let tile = getTile(at: CGPoint(x: i, y: j)), !tile.isOpened {
                    opened = false
                    break
                }
            }
            
            if opened {
                wordsIndexes.append(3 + i / 2)
            }
            
            opened = true
            for j in 0..<5 {
                if let tile = getTile(at: CGPoint(x: j, y: i)), !tile.isOpened {
                    opened = false
                    break
                }
            }
            
            if opened {
                wordsIndexes.append(i / 2)
            }
        }
        
        return wordsIndexes
    }
    
    func isSolved() -> Bool {
        return tiles.reduce(true) { partialResult, tile in
            tile.isOpened && partialResult
        }
    }
}

extension BoardModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension BoardModel {
    static func == (_ lhs: BoardModel, _ rhs: BoardModel) -> Bool {
        lhs.id == rhs.id
    }
}
