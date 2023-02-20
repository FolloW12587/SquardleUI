//
//  SubmitButtonView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct SubmitButtonView: View {
    @ObservedObject var guiModel: GameGUIModel
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
        guiModel.isSubmitButtonActive ? ThemeModel.main.mainColor : ThemeModel.main.tileMainBackgroundColor
    }
    
    func getForegroundColor() -> Color {
        guiModel.isSubmitButtonActive ? ThemeModel.main.activeForegroundColor : ThemeModel.main.secondaryForegroundColor
    }
}

struct SubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButtonView(guiModel: GameGUIModel(guessesLeft: 4), title: "ВВОД"){ }
    }
}
