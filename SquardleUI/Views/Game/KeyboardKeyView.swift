//
//  KeyboardKeyView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct KeyboardKeyView: View {
    @ObservedObject var keyModel: KeyboardKeyModel
    var tapAction: ((KeyboardKeyModel) -> Void)?
    
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            if keyModel.character == " " {
                Image(systemName: "delete.backward.fill")
                    .font(.system(size: 20, weight: .bold))
            } else {
                Text(String(keyModel.character))
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(getBackgroundColor())
        .foregroundColor(ThemeModel.main.mainForegroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
        )
        .cornerRadius(10)
        .opacity(isAnimating ? 0.4 : 1)
        .onTapGesture {
            tapAction?(keyModel)
            animateTap()
        }
    }
    
    func getBackgroundColor() -> Color {
        switch keyModel.state {
        case .def:
            return ThemeModel.main.tileMainBackgroundColor
        case .exists:
            return ThemeModel.main.mainColor
        case .notExists:
            return ThemeModel.main.notExistsColor
        }
    }
    
    func animateTap() {
        withAnimation{
            isAnimating = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation{
                isAnimating = false
            }
        }
    }
}

struct KeyboardKeyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            KeyboardKeyView(keyModel: KeyboardKeyModel.example)
                .frame(width: 70, height: 120)
                .environmentObject(GameModel())
            
            KeyboardKeyView(keyModel: KeyboardKeyModel.deleteExample)
                .frame(width: 70, height: 120)
                .environmentObject(GameModel())
        }
    }
}
