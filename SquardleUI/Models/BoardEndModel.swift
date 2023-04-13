//
//  BoardEndModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 08.04.2023.
//

import Foundation

class BoardEndModel: ObservableObject {
    var tiles: [TileModel]
    
    init(tiles: [TileModel]){
        self.tiles = tiles
    }
    
    func getTile(at position: CGPoint) -> TileModel? {
        return tiles.filter { $0.position == position }.first
    }
    
    func showSolution() {
        for tile in tiles {
            tile.showSolution = true
        }
    }
    
    static let example = BoardEndModel(tiles: [])
}
