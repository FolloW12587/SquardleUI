//
//  HorizontalArrowLineView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 24.11.2022.
//

import SwiftUI

struct HorizontalArrowLineView: View {
    let count: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<count, id: \.self){ i in
                TriangleShape()
                    .aspectRatio(1.0, contentMode: .fit)
            }
        }
    }
}

struct HorizontalArrowLineView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalArrowLineView(count: 2)
    }
}
