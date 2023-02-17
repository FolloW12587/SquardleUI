//
//  AnimatableRateNumber.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 17.02.2023.
//

import SwiftUI

struct AnimatableRateNumber: AnimatableModifier {
    var rate: CGFloat = 0
    
    var animatableData: CGFloat {
        get { rate }
        set { rate = newValue }
    }
    
    func body(content: Content) -> some View {
        return Text(String(format: "%.2f%%", rate * 100))
    }
}
