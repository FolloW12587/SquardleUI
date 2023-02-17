//
//  WinRateGraphView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 16.02.2023.
//

import SwiftUI

struct WinRateGraphView: View {
    let wins: Int
    let loses: Int
    let winRate: Float
    let loseRate: Float
    
    var body: some View {
        VStack{
            HStack{
                Color.clear
                    .modifier(AnimatableRateNumber(rate: CGFloat(winRate)))
                    .foregroundColor(.green)
                Spacer()
                Color.clear
                    .modifier(AnimatableRateNumber(rate: CGFloat(loseRate)))
                    .foregroundColor(.red)
            }
            
            AsymetricRectangleView(stopsAt: CGFloat(winRate))
                .frame(height: 10)
            
            HStack{
                Color.clear
                    .modifier(AnimatableNumber(num: CGFloat(wins), preText: "Выиграно: "))
                    .foregroundColor(.green)
                Spacer()
                Color.clear
                    .modifier(AnimatableNumber(num: CGFloat(wins), preText: "Проиграно: "))
                    .foregroundColor(.red)
            }
        }
    }
}

struct WinRateGraphView_Previews: PreviewProvider {
    static var previews: some View {
        WinRateGraphView(wins: 4, loses: 3, winRate: 4/7, loseRate: 3/7)
    }
}
