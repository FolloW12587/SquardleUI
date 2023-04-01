//
//  KeyboardKeyView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct KeyboardKeyView: View {
    @ObservedObject var keyModel: KeyboardKeyModel
    @EnvironmentObject var theme: ThemeModel
    var tapAction: (KeyboardKeyModel) -> Void
    
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
        .foregroundColor(theme.mainForegroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
        )
        .cornerRadius(10)
        .opacity(isAnimating ? 0.4 : 1)
        .onTapGesture(perform: tapped)
    }
    
    func tapped() {
        tapAction(keyModel)
        animateTap()
        TactileResponse.shared.makeResponse(feedbackStyle: .medium, systemSoundID: SoundMatcher.keyPressed.rawValue)
    }
    
    func getBackgroundColor() -> Color {
        switch keyModel.state {
        case .def:
            return theme.tileMainBackgroundColor
        case .exists:
            return theme.mainColor
        case .notExists:
            return theme.notExistsColor
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
            KeyboardKeyView(keyModel: KeyboardKeyModel.example){_ in }
                .frame(width: 70, height: 120)
                .environmentObject(GameModel())
            
            KeyboardKeyView(keyModel: KeyboardKeyModel.deleteExample){_ in }
                .frame(width: 70, height: 120)
                .environmentObject(GameModel())
        }
        .environmentObject(ThemeModel())
    }
}
