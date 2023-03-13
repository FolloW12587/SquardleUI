//
//  EndView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 13.03.2023.
//

import SwiftUI

struct EndView: View {
    @EnvironmentObject var theme: ThemeModel
    
    var randomCoords: CGSize {
        return CGSize(width: CGFloat.random(in: -100...100), height: CGFloat.random(in: -100...100))
    }
    
    var body: some View {
        ZStack{
            theme.backgroundColor
            
            particles
            
            VStack {
                Spacer()
                Text("Поздравляем!")
                    .font(.system(.title).bold())
                Spacer()
                HStack{
                    Image(systemName: "speedometer")
                    Text("Игра")
                    Spacer()
                    Text("Сложная")
                }
                .font(.system(.title3))
                .padding(.horizontal, 70)
                
                Divider()
                    .frame(height: 2)
                    .overlay(.black)
                    .padding(.horizontal, 70)
                Spacer()
                HStack {
                    Image(systemName: "chart.bar.fill")
                    Text("Статистика")
                }
                .font(.system(.title2))
                .padding(.bottom, 20)
                
                Button {
                    
                } label: {
                    Text("Продолжить")
                        .padding(20)
                        .padding(.horizontal, 30)
                        .background(Capsule().fill(theme.tileOpenedBackgroundColor))
                        .foregroundColor(.white)
                }
                .font(.system(.title).bold())
                .padding(.bottom, 20)
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Поделиться")
                    }
                }
                .foregroundColor(Color.primary)
                .font(.title2)
                .padding(.bottom, 40)
                
            }
        }
        .ignoresSafeArea()
    }
    
    var particles: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 12, height: 12)
                .modifier(FireworkParticlesModifier())
                .offset(randomCoords)
        
            Circle()
                .fill(Color.red)
                .frame(width: 12, height: 12)
                .modifier(FireworkParticlesModifier(delay: Double.random(in: 1...2)))
                .offset(randomCoords)
            
            Circle()
                .fill(Color.red)
                .frame(width: 12, height: 12)
                .modifier(FireworkParticlesModifier(delay: Double.random(in: 2...3)))
                .offset(randomCoords)
        }
    }
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView()
            .environmentObject(ThemeModel())
    }
}
