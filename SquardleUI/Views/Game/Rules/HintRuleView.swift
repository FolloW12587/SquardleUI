//
//  HintRuleView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 30.11.2022.
//

import SwiftUI

struct HintRuleView: View {
    let state: HintModel.State
    let width: CGFloat
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            HintView(hintModel: HintModel(character: "A", state: state, position: .zero, isScaled: true), width: width)
                .frame(width: width)
                .disabled(true)
            Text(text)
        }
    }
}

struct HintRuleView_Previews: PreviewProvider {
    static var previews: some View {
        HintRuleView(state: .exists, width: 50, text: " - правильная буква для этой клетки. Задача игры как раз и состоит в том, чтобы все клетки стали зелеными.")
    }
}
