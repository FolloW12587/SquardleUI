//
//  MenuButton.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct MenuButton<Destination: View>: View {
    let title: String
    let destinationView: () -> Destination
    
    var body: some View {
        NavigationLink {
            destinationView()
        } label: {
            Text(title.uppercased())
        }
        .buttonStyle(MenuButtonStyle())
    }
}

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(ThemeModel.main.mainForegroundColor)
            .font(.system(size: 22, weight: .bold))
            .padding(10)
            .frame(minWidth: 200)
            .background(ThemeModel.main.mainColor)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(title: "Menu Button"){
            EmptyView()
        }
    }
}
