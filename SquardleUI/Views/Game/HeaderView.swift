//
//  HeaderView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 23.11.2022.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var guiModel: GameGUIModel
    var dismissAction: () -> ()
    
    var body: some View {
        HStack {
            Button(action: dismissAction) {
                Image(systemName: "house.circle")
            }

            Spacer()
            ZStack {
                Text("\(guiModel.guessesLeft)")
                    .foregroundColor(getGuessesLeftColor())
                    .bold()
                
                Text(getNumWithSign(guiModel.guessesAdded))
                    .foregroundColor(getGuessesAddedColor())
                    .opacity(guiModel.animateGuessesAdded ? 1 : 0)
                    .offset(y: guiModel.animateGuessesAdded ? 30 : 0)
                    .animation(.easeInOut(duration: 1), value: guiModel.animateGuessesAdded)
            }
            Spacer()
            
            Button {
                guiModel.areRulesPresented = true
            } label: {
                Image(systemName: "questionmark.circle")
            }
        }
        .foregroundColor(Color.primary)
        .font(.system(size: 30))
        .padding(.horizontal, 25)
        .sheet(isPresented: $guiModel.areRulesPresented) {
            RulesView()
        }
        .sheet(isPresented: $guiModel.areStatsPresented) {
            GameStatsView()
        }
    }
    
    func getGuessesLeftColor() -> Color {
        if guiModel.guessesLeft < 3 {
            return .red
        }
        
        if guiModel.guessesLeft < 6 {
            return .orange
        }
        
        return .primary
    }
    
    func getNumWithSign(_ num: Int) -> String {
        if num <= 0 { return "\(num)" }
        return "+\(num)"
    }
    
    func getGuessesAddedColor() -> Color {
        if guiModel.guessesAdded < 0 {
            return .red
        }
        
        if guiModel.guessesAdded == 0 {
            return .primary
        }
        
        return .green
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(guiModel: GameGUIModel(guessesLeft: 3)){}
    }
}
