//
//  MenuButton.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct MenuButton: View {
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(title.uppercased())
        }
        .buttonStyle(MenuButtonStyle())
    }
}

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.system(size: 22, weight: .bold))
            .padding(10)
            .frame(minWidth: 200)
            .background(ThemeModel.main.tileOpenedBackgroundColor)
            .cornerRadius(20)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(title: "Menu Button"){}
    }
}
