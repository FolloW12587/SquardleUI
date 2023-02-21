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
            Text("\(guiModel.guessesLeft)")
                .foregroundColor(getGuessesLeftColor())
                .bold()
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
        
        return Color.primary
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(guiModel: GameGUIModel(guessesLeft: 3)){}
    }
}
