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
                Text(String(format: "%.2f%%", winRate * 100))
                    .foregroundColor(.green)
                Spacer()
                Text(String(format: "%.2f%%", loseRate * 100))
                    .foregroundColor(.red)
            }
            
            AsymetricRectangleView(stopsAt: CGFloat(winRate))
                .frame(height: 10)
            
            HStack{
                Text("Выиграно: \(wins)")
                    .foregroundColor(.green)
                Spacer()
                Text("Проиграно: \(loses)")
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
