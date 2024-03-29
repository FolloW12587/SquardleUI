//
//  KeyboardView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

struct KeyboardView: View {
    var keyboardModel: KeyboardModel
    let keyHeight: CGFloat = 50
    
    var tapAction: ((KeyboardKeyModel) -> ())
    
    var body: some View {
        VStack {
            HStack(spacing: 3) {
                ForEach(keyboardModel.firstRow, id: \.self){ keyModel in
                    KeyboardKeyView(keyModel: keyModel, tapAction: tapAction)
                }
            }
            .frame(height: keyHeight)
            
            HStack(spacing: 3) {
                ForEach(keyboardModel.secondRow, id: \.self){ keyModel in
                    KeyboardKeyView(keyModel: keyModel, tapAction: tapAction)
                }
            }
            .frame(height: keyHeight)
            
            HStack(spacing: 3) {
                ForEach(keyboardModel.thirdRow, id: \.self){ keyModel in
                    KeyboardKeyView(keyModel: keyModel, tapAction: tapAction)
                }
            }
            .frame(height: keyHeight)
        }
        .padding(.horizontal, 5)
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(keyboardModel: KeyboardModel()){ _ in }
    }
}
