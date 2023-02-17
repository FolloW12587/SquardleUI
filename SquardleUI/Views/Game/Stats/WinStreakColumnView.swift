//
//  WinStreakColumnView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 16.02.2023.
//

import SwiftUI

struct WinStreakColumnView: View {
    let index: Int
    let bestStreak: Int
    let currentStreak: Int
    let value: Int
    let height: CGFloat
    let isLast: Bool
    
    var heightRatio: CGFloat {
        CGFloat(value) / CGFloat(bestStreak)
    }
    
    var color: Color {
        if isLast && currentStreak != 0 {
            return .yellow
        }
        
        if value >= bestStreak {
            return .green
        }
        
        return Color(white: 0.3)
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .frame(height: height * heightRatio)
                .cornerRadius(5)
                .animation(.spring().delay(0.05 * Double(index)), value: value)
            
            Text("\(value)")
                .foregroundColor(color)
        }
            
    }
}

struct WinStreakColumnView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            WinStreakColumnView(index: 0, bestStreak: 4, currentStreak: 1, value: 2, height: 150, isLast: false)
                .frame(width: 50, height: 150)
            WinStreakColumnView(index: 0, bestStreak: 4, currentStreak: 1, value: 4, height: 150, isLast: false)
                .frame(width: 50, height: 150)
        }
    }
}
