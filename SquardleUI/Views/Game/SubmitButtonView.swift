//
//  SubmitButtonView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct SubmitButtonView: View {
    @ObservedObject var guiModel: GameGUIModel
    @EnvironmentObject var theme: ThemeModel
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: animatedAction) {
            Text(title)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(getForegroundColor())
        }
        .background(getBackgroundColor())
        .cornerRadius(10)
    }
    
    func animatedAction() {
        withAnimation{
            action()
        }
    }
    
    func getBackgroundColor() -> Color {
        guiModel.isSubmitButtonActive ? theme.mainColor : theme.tileMainBackgroundColor
    }
    
    func getForegroundColor() -> Color {
        guiModel.isSubmitButtonActive ? theme.activeForegroundColor : theme.secondaryForegroundColor
    }
}

struct SubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButtonView(guiModel: GameGUIModel(guessesLeft: 4), title: "ВВОД"){ }
            .environmentObject(ThemeModel())
    }
}
