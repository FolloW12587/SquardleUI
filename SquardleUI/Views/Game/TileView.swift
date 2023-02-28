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
    
    var foregroundColor: Color {
        if tileModel.tempCharacter != nil || tileModel.showSolution {
            return theme.mainForegroundColor
        }
        
        if tileModel.state == .opened {
            return theme.activeForegroundColor
        }
        
        if tileModel.markedCharacter != nil && tileModel.state == .markedSure{
            return theme.mainForegroundColor
        }
        
        return theme.secondaryForegroundColor
    }
    
    var backgroundColor: Color {
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
    
    var body: some View {
        ZStack {
            character
            
            GeometryReader { geometry in
                ForEach(tileModel.hints, id: \.self) { hint in
                    HintView(hintModel: hint, width: geometry.size.width, position: getHintViewPosition(size: geometry.size, hintPosition: hint.position))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fit)
        .background(backgroundColor)
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
        .animation(.easeInOut(duration: 0.2).delay((tileModel.position.x + tileModel.position.y) * 0.2), value: tileModel.showSolution)
        .scaleEffect(tileModel.showEndAnimation ? 1.5 : 1)
        .animation(.easeInOut(duration: 0.2).delay((tileModel.position.x + tileModel.position.y) * 0.1), value: tileModel.showEndAnimation)
        .scaleEffect(tileModel.showEndAnimation ? 1.5 : 1)
        .animation(.easeInOut(duration: 0.2).delay(0.8 + (10 - tileModel.position.x - tileModel.position.y) * 0.1), value: tileModel.showEndAnimation)
        
        .scaleEffect(tileModel.showAnimationInRow ? 1.5 : 1)
        .animation(.easeInOut(duration: 0.2).delay(tileModel.position.x * 0.1), value: tileModel.showAnimationInRow)
        
        .scaleEffect(tileModel.showAnimationInColumn ? 1.5 : 1)
        .animation(.easeInOut(duration: 0.2).delay(tileModel.position.y * 0.1), value: tileModel.showAnimationInColumn)
    }
    
    var character: some View {
        ZStack{
            if let character = tileModel.tempCharacter {
                Text(String(character))
                    .font(.system(size: 35, weight: .bold))
                    .offset(x: tileModel.wrongGuessedWord ? -10 : 0)
                    .animation(Animation.default.repeatCount(3, autoreverses: true).speed(6), value: tileModel.wrongGuessedWord)
                    .foregroundColor(foregroundColor)
            } else if tileModel.showSolution {
                Text(String(tileModel.character))
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(foregroundColor)
            } else if tileModel.state == .opened {
                Text(String(tileModel.character))
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(foregroundColor)
            } else if let character = tileModel.markedCharacter {
                Text(String(character))
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(foregroundColor)
            }
        }
    }
    
    func getHintViewPosition(size: CGSize, hintPosition: CGPoint) -> CGPoint {
        CGPoint(x: size.width / 8 + size.width * hintPosition.x / 4, y: size.height / 8 + size.height * hintPosition.y / 4)
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
