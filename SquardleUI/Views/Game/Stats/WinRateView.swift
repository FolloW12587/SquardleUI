//
//  WinRateView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 16.02.2023.
//

import SwiftUI

struct WinRateView: View {
    let wins: Int
    let loses: Int
    let winRate: Float
    let loseRate: Float
    
    var body: some View {
        VStack(spacing: 10){
            VStack{
                Text("Сыграно")
                Color.clear
                    .modifier(AnimatableNumber(num: CGFloat(wins + loses)))
                    .font(.title.bold())
            }
            
            WinRateGraphView(wins: wins, loses: loses, winRate: winRate, loseRate: loseRate)
        }
    }
}

struct WinRateView_Previews: PreviewProvider {
    static let stats = StatsModel.testStats
    
    static var previews: some View {
        WinRateView(wins: stats.totalWins, loses: stats.totalLoses, winRate: stats.winRate, loseRate: stats.loseRate)
    }
}
