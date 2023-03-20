//
//  EndView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 13.03.2023.
//

import SwiftUI

struct EndView: View {
    @EnvironmentObject var theme: ThemeModel
//    let words: [String]
//    let guessesUsed: Int
//    let gameMode: GameModel.GameMode
    let lastGamePlayed: LastGamePlayed
    let homeAction: () -> ()
    let statsAction: () -> ()
    
    var wordsString: String {
        var s: String = "\n\n"
        for word in lastGamePlayed.words {
            s += "\(word)\n"
        }
        return s
    }
    var gameModeString: String {
        switch lastGamePlayed.gameMode {
        case .normal:
            return "обычный"
        case .hard:
            return "сложный"
        }
    }
    var url: String = "https://apps.apple.com/us/app/%D1%88%D0%B5%D1%81%D1%82%D1%8C-%D1%81%D0%BB%D0%BE%D0%B2/id1665411397"
    
    var winText: String {
        "Я только что прошел \(gameModeString) уровень в игре \"Шесть Слов\" за \(lastGamePlayed.guessesUsed) ходов, и отгадал слова \(wordsString)\nА ты сможешь?\n"
    }
    
    @State var showShareSheet = false
    
    var randomCoords: CGSize {
        return CGSize(width: CGFloat.random(in: -100...100), height: CGFloat.random(in: -100...100))
    }
    
    var body: some View {
        ZStack{
            theme.backgroundColor
            
            particles
            
            VStack {
                Spacer()
                Text("Победа!")
                    .font(.system(.title).bold())
                Spacer()
                
                gameStats
                
                Spacer()
                Button(action: statsAction) {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                        Text("Статистика")
                    }
                }
                .font(.system(.title2))
                .padding(.bottom, 20)
                .foregroundColor(Color.primary)
                
                Button(action: homeAction){
                    Text("Продолжить")
                        .padding(20)
                        .padding(.horizontal, 30)
                        .background(Capsule().fill(theme.tileOpenedBackgroundColor))
                        .foregroundColor(.white)
                }
                .font(.system(.title).bold())
                .padding(.bottom, 20)
                
                Button {
                    showShareSheet = true
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
        .sheet(isPresented: $showShareSheet) {
            ActivityViewController(itemsToShare: [winText, url])
        }
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
    
    var gameStats: some View {
        VStack {
            HStack{
                Image(systemName: "speedometer")
                Text("Режим")
                Spacer()
                Text(gameModeString.capitalized)
            }
            .font(.system(.title3))
            .padding(.horizontal, 70)
        
            Divider()
                .frame(height: 2)
                .overlay(.primary)
                .padding(.horizontal, 70)
            
            HStack{
                Image(systemName: "number")
                Text("Ходов")
                Spacer()
                Text("\(lastGamePlayed.guessesUsed)")
            }
            .font(.system(.title3))
            .padding(.horizontal, 70)
        }
    }
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView(lastGamePlayed: LastGamePlayed(words: ["КАТЕР", "САПЕР"], guessesUsed: 6, gameMode: .hard)){} statsAction: {}
            .environmentObject(ThemeModel())
    }
}
