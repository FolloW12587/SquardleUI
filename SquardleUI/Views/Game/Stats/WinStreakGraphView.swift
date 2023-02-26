//
//  WinStreakGraphView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 16.02.2023.
//

import SwiftUI

struct WinStreakGraphView: View {
    let bestStreak: Int
    let currentStreak: Int
    let streaks: [Int]
    
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: proxy.size.width / 100) {
                ForEach(Array(streaks.enumerated()), id: \.offset){ index, streak in
                    WinStreakColumnView(
                        index: index,
                        bestStreak: bestStreak,
                        currentStreak: currentStreak,
                        value: streak,
                        height: proxy.size.height,
                        isLast: index == streaks.count - 1)
                        .frame(width: proxy.size.width / 11)
                }
            }
        }
    }
}

struct WinStreakGraphView_Previews: PreviewProvider {
    static let stats = StatsModel.testStats
    
    static var previews: some View {
        WinStreakGraphView(bestStreak: stats.bestStreak,
                           currentStreak: stats.currentStreak,
                           streaks: stats.streaks)
            .frame(height: 150)
    }
}
