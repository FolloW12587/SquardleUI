//
//  KeyboardKeyRuleView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 01.12.2022.
//

import SwiftUI

struct KeyboardKeyRuleView: View {
    let state: KeyboardKeyModel.State
    let width: CGFloat
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            KeyboardKeyView(keyModel: KeyboardKeyModel(character: "А", state: state)){_ in}
                .frame(width: width, height: width * 1.5)
                .disabled(true)
            Text(text)
        }
    }
}

struct KeyboardKeyRuleView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardKeyRuleView(state: .def, width: 50, text: " - text")
    }
}
