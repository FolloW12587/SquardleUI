//
//  BoardView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var boardModel: BoardModel
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0){
            ForEach([0, 1, 2, 3, 4], id: \.self){ y in
                ForEach([0, 1, 2, 3, 4], id: \.self){ x in
                    if let tileModel = boardModel.getTile(at: CGPoint(x: x, y: y)) {
                        TileView(tileModel: tileModel)
                    } else {
                        Text("")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(boardModel: BoardModel.example)
            .environmentObject(GameModel())
    }
}
