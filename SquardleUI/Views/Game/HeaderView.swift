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
            Spacer()
            
            Button {
                guiModel.areRulesPresented = true
            } label: {
                Image(systemName: "questionmark.circle")
            }
        }
        .foregroundColor(ThemeModel.main.mainForegroundColor)
        .font(.system(size: 30))
        .padding(.horizontal, 25)
        .sheet(isPresented: $guiModel.areRulesPresented) {
            RulesView()
        }
        .sheet(isPresented: $guiModel.areStatsPresented) {
            GameStatsView()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(guiModel: GameGUIModel()){}
    }
}
