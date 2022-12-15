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
                
                Group{
                    HStack{
                        Text("Общая статистика:")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    
                    HStack{
                        Text("Игр сыграно:")
                        Spacer()
                        Text("\(stats.totalGames)")
                    }
                    
                    HStack{
                        Text("Игр выиграно:")
                        Spacer()
                        Text("\(stats.totalWins)")
                    }
                    
                    HStack{
                        Text("Процент побед:")
                        Spacer()
                        Text(String(format: "%.2f%%", stats.winRate * 100))
                    }
                }
                
                
                Group{
                    HStack{
                        Text("Подряд:")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    
                    HStack{
                        Text("Текущий стрик:")
                        Spacer()
                        Text("\(stats.currentStreak)")
                    }
                    
                    HStack{
                        Text("Лучший стрик:")
                        Spacer()
                        Text("\(stats.bestStreak)")
                    }
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
            .environmentObject(StatsModel())
    }
}
