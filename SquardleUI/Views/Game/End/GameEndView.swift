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
    let showSolutionAction: () -> ()
    let url = "https://apps.apple.com/us/app/%D1%88%D0%B5%D1%81%D1%82%D1%8C-%D1%81%D0%BB%D0%BE%D0%B2/id1665411397"
    let winText = "Я только что прошел уровень в игре \"Шесть Слов\". А ты сможешь?\n"
    
    @State var showShareSheet = false
    
    var body: some View {
        ZStack {
            theme.backgroundColor
            
            VStack {
                ZStack {
                    
                    Text(isGameWon ? "Победа!" : "Eще раз?")
                        .foregroundColor(isGameWon ? .green : .red)
                    .font(.title.bold())
                    
                    
                    if isGameWon {
                        HStack {
                            Spacer()
                            
                            Button {
                                showShareSheet = true
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                            .foregroundColor(Color.primary)
                            .font(.system(size: 30))
                            .padding(.trailing)
                        }
                    }
                }
                
                Button(action: showSolutionAction) {
                    Text("Решение")
                }
                .buttonStyle(MenuButtonStyle())
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
        .scaledToFit()
        .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
        .padding(.horizontal, 50)
        .clipped()
        .shadow(radius: 4)
        .sheet(isPresented: $showShareSheet) {
            ActivityViewController(itemsToShare: [winText, url])
        }
    }
}

struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndView(isGameWon: true) {
        } statsAction: {
        } restartAction: {
        } showSolutionAction: {
        }
        .environmentObject(ThemeModel())
    }
}
