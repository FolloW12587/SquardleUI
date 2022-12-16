//
//  HintView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 24.11.2022.
//

import SwiftUI

struct HintView: View {
    @ObservedObject var hintModel: HintModel
    let textCoef = 0.5
    let arrowsCoef = 0.25

    var width: CGFloat = 200
    var position: CGPoint = .zero
    
    var body: some View {
        ZStack {
            if !hintModel.isHidden {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        verticalLine
                            .rotationEffect(.degrees(180))
                            .frame(width: geometry.size.width * arrowsCoef, height: geometry.size.height * textCoef)
                        
                        VStack(spacing: 0) {
                            horizontalLine
                                .frame(width: geometry.size.width * textCoef, height: geometry.size.height * arrowsCoef)
                            
                            Text(String(hintModel.character))
                                .font(.system(size: 1000, weight: .bold))
                                .foregroundColor(getForegroundColor())
                                .frame(width: geometry.size.width * textCoef, height: geometry.size.height * textCoef)
                                .minimumScaleFactor(0.001)
                            
                            horizontalLine
                                .rotationEffect(.degrees(180))
                                .frame(width: geometry.size.width * textCoef, height: geometry.size.height * arrowsCoef)
                        }
                        
                        verticalLine
                            .frame(width: geometry.size.width * arrowsCoef, height: geometry.size.height * textCoef)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fit)
        .background(getBackgroundColor())
        .cornerRadius(7)
        .scaleEffect(getScale())
        .frame(width: width)
        .position(getPosition())
        .zIndex(getZIndex())
        .onTapGesture(perform: tapped)
        .onLongPressGesture(perform: longPressed)
        .onAppear(perform: appeared)
    }
    
    var verticalLine: some View {
        ZStack {
            if case .existsInRowOrColumn(inRowCount: let inRowCount, inColumnCount: _) = hintModel.state {
                VerticalArrowLineView(count: inRowCount)
                    .foregroundColor(getForegroundColor())
            }
        }
    }
    
    var horizontalLine: some View {
        ZStack {
            if case .existsInRowOrColumn(inRowCount: _, inColumnCount: let inColumnCount) = hintModel.state {
                HorizontalArrowLineView(count: inColumnCount)
                    .foregroundColor(getForegroundColor())
            }
        }
    }
    
    func tapped() {
        withAnimation {
            hintModel.tapped()
        }
    }
    
    func longPressed() {
        withAnimation {
            hintModel.longPressed()
        }
    }
    
    func appeared() {
        withAnimation {
            hintModel.appeared()
        }
    }
    
    func getScale() -> CGFloat {
        if hintModel.isScaled {
            return 1
        } else if hintModel.isHidden {
            return 0.125
        } else {
            return 0.25
        }
    }
    
    func getZIndex() -> CGFloat {
        hintModel.isScaled ? 10 : 1
    }
    
    func getPosition() -> CGPoint {
        hintModel.isScaled ? CGPoint(x: width / 2, y: width / 2) : position
    }
    
    func getBackgroundColor() -> Color {
        switch hintModel.state {
        case .notExists:
            return ThemeModel.main.notExistsColor
        case .exists:
            return ThemeModel.main.existsColor
        case .existsInRowOrColumn(inRowCount: let inRowCount, inColumnCount: let inColumnCount):
            if inRowCount == 0 {
                return ThemeModel.main.existsInColumnColor
            }
            if inColumnCount == 0 {
                return ThemeModel.main.existsInRowColor
            }
            
            return ThemeModel.main.existsInRowAndColumnColor
        }
    }
    
    func getForegroundColor() -> Color {
        switch hintModel.state {
        case .notExists:
            return ThemeModel.main.notExistsForegroundColor
        case .exists:
            return ThemeModel.main.existsForegroundColor
        case .existsInRowOrColumn(inRowCount: let inRowCount, inColumnCount: let inColumnCount):
            if inRowCount == 0 {
                return ThemeModel.main.existsInColumnForegroundColor
            }
            if inColumnCount == 0 {
                return ThemeModel.main.existsInRowForegroundColor
            }
            
            return ThemeModel.main.existsInRowAndColumnForegroundColor
        }
    }
}

struct HintView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HintView(hintModel: HintModel.exampleInRowAndColumn)
                .frame(width: 200)
            
            HintView(hintModel: HintModel.exampleInRow)
                .frame(width: 200)
            
            HintView(hintModel: HintModel.exampleInColumn)
                .frame(width: 200)
        }
    }
}
