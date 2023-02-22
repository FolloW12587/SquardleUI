//
//  GameEndView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 02.12.2022.
//

import SwiftUI

struct GameEndView: View {
    @EnvironmentObject var theme: ThemeModel
    let isGameWon: Bool
    let homeAction: () -> ()
    let statsAction: () -> ()
    let restartAction: () -> ()
    
    var body: some View {
        ZStack {
            theme.backgroundColor
            
            VStack {
                Text(isGameWon ? "Победа!" : "Eще раз?")
                    .foregroundColor(isGameWon ? .green : .red)
                    .font(.title.bold())
                    .padding()
                
                HStack {
                    Spacer()
                    Button (action: homeAction){
                        Image(systemName: "house.circle")
                    }
                    Spacer()
                    Button(action: statsAction) {
                        Image(systemName: "list.star")
                    }
                    Spacer()
                    
                    Button(action: restartAction) {
                        Image(systemName: "arrow.counterclockwise.circle")
                    }
                    Spacer()
                }
                .foregroundColor(Color.primary)
                .font(.system(size: 50))
            }
        }
        .frame(maxWidth: .infinity)
        .scaledToFit()
        .padding(.horizontal, 50)
        .clipped()
        .shadow(radius: 4)
    }
}

struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndView(isGameWon: false) {
        } statsAction: {
        } restartAction: {
        }
        .environmentObject(ThemeModel())
    }
}
