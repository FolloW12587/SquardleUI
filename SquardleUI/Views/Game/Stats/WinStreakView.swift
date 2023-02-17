//
//  WinStreakView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 16.02.2023.
//

import SwiftUI

struct WinStreakView: View {
    let bestStreak: Int
    let currentStreak: Int
    let streaks: [Int]
    
    var body: some View {
        VStack{
            Text("Серии побед")
                .font(.title2.bold())
                .padding(.bottom)
            
            HStack {
                
                Spacer()
                VStack{
                    Text("Текущая")
                    Color.clear
                        .modifier(AnimatableNumber(num: CGFloat(currentStreak)))
                        .font(.title.bold())
                }
                
                Spacer()
                
                VStack{
                    Text("Лучшая")
                    HStack(spacing: 0) {
                        Color.clear
                            .modifier(AnimatableNumber(num: CGFloat(bestStreak)))
                            .font(.title.bold())
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                    }
                }
                
                Spacer()
            }
            
            WinStreakGraphView(bestStreak: bestStreak, currentStreak: currentStreak, streaks: streaks)
                .frame(height: 150)
        }
    }
}

struct WinStreakView_Previews: PreviewProvider {
    static let stats = StatsModel.testStats
    
    static var previews: some View {
        WinStreakView(bestStreak: stats.bestStreak, currentStreak: stats.currentStreak, streaks: stats.streaks)
    }
}
