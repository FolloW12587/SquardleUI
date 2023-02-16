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
        Rectangle()
            .fill(
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: leftColor, location: stopsAt),
                    Gradient.Stop(color: rightColor, location: stopsAt)
                ]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(10)
    }
}

struct AsymetricRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        AsymetricRectangleView()
            .frame(width: .infinity, height: 50)
    }
}
