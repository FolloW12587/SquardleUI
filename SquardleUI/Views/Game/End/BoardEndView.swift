//
//  BoardEndView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 08.04.2023.
//

import SwiftUI

struct BoardEndView: View {
    var boardModel: BoardEndModel
    
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
                            .disabled(true)
                    } else {
                        Color.clear
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct BoardEndView_Previews: PreviewProvider {
    static var previews: some View {
        BoardEndView(boardModel: .example)
    }
}
