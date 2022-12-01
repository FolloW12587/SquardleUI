//
//  TileView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct TileView: View {
    @EnvironmentObject var gameModel: GameModel
    @ObservedObject var tileModel: TileModel
    
    
    var body: some View {
        ZStack {
            if tileModel.tempCharacter != nil {
                Text(String(tileModel.tempCharacter!))
                    .font(.system(size: 35, weight: .bold))
                    .offset(x: tileModel.wrongGuessedWord ? -10 : 0)
                    .animation(Animation.default.repeatCount(3, autoreverses: true).speed(6), value: tileModel.wrongGuessedWord)
                    .foregroundColor(ThemeModel.main.mainForegroundColor)
                
            } else if tileModel.state == .opened {
                Text(String(tileModel.character))
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(ThemeModel.main.activeForegroundColor)
                
            } else if tileModel.markedCharacter != nil {
                Text(String(tileModel.markedCharacter!))
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(tileModel.state == .markedSure ? ThemeModel.main.mainForegroundColor : ThemeModel.main.secondaryForegroundColor)
            }
            
            GeometryReader { geometry in
                ForEach(tileModel.hints, id: \.self) { hint in
                    HintView(hintModel: hint, width: geometry.size.width, position: CGPoint(x: geometry.size.width / 8 + geometry.size.width * hint.position.x / 4, y: geometry.size.height / 8 + geometry.size.height * hint.position.y / 4))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fit)
        .background(getBackgroundColor())
        .overlay(
            RoundedRectangle(cornerRadius: 7)
                .stroke(tileModel.isOnGuessingWay ? Color.yellow : .gray, lineWidth: tileModel.isOnGuessingWay ? 4 : 2)
        )
        .cornerRadius(7)
        .onTapGesture {
            withAnimation{
                tileModel.clicked()
            }
            gameModel.tileTapped(tileModel)
        }
    }
    
    func getBackgroundColor() -> Color {
        switch tileModel.state {
        case .none:
            return ThemeModel.main.tileMainBackgroundColor
        case .editting:
            return ThemeModel.main.tileEdittingBackgroundColor
        case .opened:
            return ThemeModel.main.tileOpenedBackgroundColor
        case .markedSure, .markedNotSure:
            return ThemeModel.main.mainColor
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TileView(tileModel: TileModel.example)
                .frame(width: 200)
                .environmentObject(GameModel())
            
//            TileView(tileModel: TileModel.exampleOnGuessingWay)
//                .frame(width: 200)
//                .environmentObject(GameModel())
//            
//            TileView(tileModel: TileModel.exampleOpened)
//                .frame(width: 200)
//                .environmentObject(GameModel())
//            
//            TileView(tileModel: TileModel.exampleMarkedSure)
//                .frame(width: 200)
//                .environmentObject(GameModel())
//            
//            TileView(tileModel: TileModel.exampleEditting)
//                .frame(width: 200)
//                .environmentObject(GameModel())
            
            TileView(tileModel: TileModel.exampleWithHints)
                .frame(width: 200)
                .environmentObject(GameModel())
        }
    }
}
