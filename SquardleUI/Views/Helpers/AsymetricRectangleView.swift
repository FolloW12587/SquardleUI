//
//  AsymetricRectangleView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 16.02.2023.
//

import SwiftUI

struct AsymetricRectangleView: View {
    var stopsAt: CGFloat = 0.2
    var leftColor: Color = .green
    var rightColor: Color = .red
    
    var body: some View {
        Color.clear
            .modifier(AnimatableGradient(leftColor: leftColor, rightColor: rightColor, stopsAt: stopsAt))
    }
}

struct AsymetricRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        AsymetricRectangleView()
            .frame(width: .infinity, height: 50)
    }
}
