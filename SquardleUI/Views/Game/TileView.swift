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
    @EnvironmentObject var theme: ThemeModel
    
    var body: some View {
        ZStack {
            if tileModel.tempCharacter != nil {
                Text(String(tileModel.tempCharacter!))
                    .font(.system(size: 35, weight: .bold))
                    .offset(x: tileModel.wrongGuessedWord ? -10 : 0)
                    .animation(Animation.default.repeatCount(3, autoreverses: true).speed(6), value: tileModel.wrongGuessedWord)
                    .foregroundColor(getForegroundColor())
                
            } else if tileModel.state == .opened {
                Text(String(tileModel.character))
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(getForegroundColor())
                
            } else if tileModel.markedCharacter != nil {
                Text(String(tileModel.markedCharacter!))
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(getForegroundColor())
            }
            
            GeometryReader { geometry in
                ForEach(tileModel.hints, id: \.self) { hint in
                    HintView(hintModel: hint, width: geometry.size.width, position: getHintViewPosition(size: geometry.size, hintPosition: hint.position))
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
    
    func getHintViewPosition(size: CGSize, hintPosition: CGPoint) -> CGPoint {
        CGPoint(x: size.width / 8 + size.width * hintPosition.x / 4, y: size.height / 8 + size.height * hintPosition.y / 4)
    }
    
    func getBackgroundColor() -> Color {
        switch tileModel.state {
        case .none:
            return theme.tileMainBackgroundColor
        case .editting:
            return theme.tileEdittingBackgroundColor
        case .opened:
            return theme.tileOpenedBackgroundColor
        case .markedSure, .markedNotSure:
            return theme.mainColor
        }
    }
    
    func getForegroundColor() -> Color {
        if tileModel.tempCharacter != nil {
            return theme.mainForegroundColor
        } else if tileModel.state == .opened {
            return theme.activeForegroundColor
            
        } else if tileModel.markedCharacter != nil && tileModel.state == .markedSure{
            return theme.mainForegroundColor
        }
        return theme.secondaryForegroundColor
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TileView(tileModel: TileModel.example)
                .frame(width: 200)
            
//            TileView(tileModel: TileModel.exampleOnGuessingWay)
//                .frame(width: 200)
//            
//            TileView(tileModel: TileModel.exampleOpened)
//                .frame(width: 200)
//            
//            TileView(tileModel: TileModel.exampleMarkedSure)
//                .frame(width: 200)
//            
//            TileView(tileModel: TileModel.exampleEditting)
//                .frame(width: 200)
            
            TileView(tileModel: TileModel.exampleWithHints)
                .frame(width: 200)
        }
        .environmentObject(GameModel())
        .environmentObject(ThemeModel())
    }
}
