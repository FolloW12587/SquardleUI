//
//  AnimatableNumber.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 17.02.2023.
//

import SwiftUI

struct AnimatableNumber: AnimatableModifier {
    var num: CGFloat = 0
    var preText: String = ""
    var postText: String = ""
    
    var animatableData: CGFloat {
        get { num }
        set { num = newValue }
    }
    
    func body(content: Content) -> some View {
        return Text("\(preText)\(Int(num))\(postText)")
    }
}
