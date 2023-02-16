//
//  GameStatsView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 15.12.2022.
//

import SwiftUI

struct GameStatsView: View {
    @EnvironmentObject var stats: StatsModel
    var dismissAction: (() -> ())? = nil
    
    var body: some View {
        ZStack {
            ThemeModel.main.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                if dismissAction != nil {
                    DismissButtonView(dismissAction: dismissAction!)
                }
                
                Text("Статистка")
                    .font(.title.bold())
                    .padding(.bottom)
                
                if stats.totalGames > 0 {
                    WinRateView(wins: stats.totalWins, loses: stats.totalLoses, winRate: stats.winRate, loseRate: stats.loseRate)
                        .padding(.bottom)
                    
                    WinStreakView(bestStreak: stats.bestStreak, currentStreak: stats.currentStreak, streaks: stats.streaks)
                } else {
                    Text("Сыграй больше игр чтобы тут появилась статистика о твоих победах и поражениях!")
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct GameStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatsView(dismissAction: {})
            .environmentObject(StatsModel.testStats)
    }
}
