//
//  GameStatsView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 15.12.2022.
//

import SwiftUI

struct GameStatsView: View {
    @EnvironmentObject var stats: StatsModel
    @EnvironmentObject var theme: ThemeModel
    var dismissAction: (() -> ())? = nil
    @State var isAnimating = true
    @State var showResetAlert: Bool = false
    
    var body: some View {
        ZStack {
            theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                if dismissAction != nil {
                    DismissButtonView(dismissAction: dismissAction!)
                }
                
                Text("Статистка")
                    .font(.title.bold())
                    .padding(.bottom)
                
                if stats.totalGames > 0 {
                    WinRateView(wins: isAnimating ? 0 : stats.totalWins, loses: isAnimating ? 0 : stats.totalLoses, winRate: isAnimating ? 0.5 : stats.winRate, loseRate: isAnimating ? 0.5 : stats.loseRate)
                        .padding(.bottom)
                    
                    WinStreakView(bestStreak: isAnimating ? 1 : stats.bestStreak, currentStreak: isAnimating ? 0 : stats.currentStreak, streaks: isAnimating ? Array(repeating: 0, count: stats.streaks.count) : stats.streaks)
                        .padding(.bottom, 40)
                } else {
                    Text("Сыграй больше игр чтобы тут появилась статистика о твоих победах и поражениях!")
                }
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Spacer()
                }
                
                Button {
                    showResetAlert = true
                } label: {
                    Text("Сбросить статистику")
                        .foregroundColor(.white)
                        .font(.title3)
                }
                .padding()
                .background(Capsule()
                    .fill(.red))
                .clipShape(Capsule())
            }
            .padding()
            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
        }
        .onAppear{
            withAnimation {
                isAnimating = false
            }
        }
        .alert("Вы уверены, что хотите сбросить статистику? Это действие не может быть отменено!", isPresented: $showResetAlert) {
            Button("Сбросить", role: .destructive, action: stats.reset)
            Button("Отменить", role: .cancel) {}
        }
    }
}

struct GameStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatsView(dismissAction: {})
            .environmentObject(StatsModel.testStats)
            .environmentObject(ThemeModel())
    }
}
