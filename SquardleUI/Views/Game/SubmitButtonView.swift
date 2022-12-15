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
        Button{
            withAnimation{
                action()
            }
        } label: {
            Text(title)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(guiModel.isSubmitButtonActive ? ThemeModel.main.activeForegroundColor : ThemeModel.main.secondaryForegroundColor)
        }
        .background(guiModel.isSubmitButtonActive ? ThemeModel.main.mainColor : ThemeModel.main.tileMainBackgroundColor)
        .cornerRadius(10)

    }
}

struct SubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButtonView(guiModel: GameGUIModel(), title: "ВВОД"){ }
    }
}
