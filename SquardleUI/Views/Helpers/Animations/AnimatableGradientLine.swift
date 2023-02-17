//
//  AnimatableGradientLine.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 17.02.2023.
//

import SwiftUI


struct AnimatableGradient: AnimatableModifier {
    let leftColor: Color
    let rightColor: Color
    var stopsAt: CGFloat = 0
    
    var animatableData: CGFloat {
        get { stopsAt }
        set { stopsAt = newValue }
    }
    
    func body(content: Content) -> some View {
        return RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: leftColor, location: stopsAt),
                    Gradient.Stop(color: rightColor, location: stopsAt)
                ]), startPoint: .leading, endPoint: .trailing))
    }
}
