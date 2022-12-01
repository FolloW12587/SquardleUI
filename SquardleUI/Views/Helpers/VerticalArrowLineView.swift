//
//  VerticalArrowLineView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 24.11.2022.
//

import SwiftUI

struct VerticalArrowLineView: View {
    let count: Int
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<count, id: \.self){ i in
                TriangleShape()
                    .aspectRatio(1.0, contentMode: .fit)
                    .rotationEffect(.degrees(90))
            }
        }
        .clipped()
    }
}

struct VerticalArrowLineView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalArrowLineView(count: 2)
    }
}
