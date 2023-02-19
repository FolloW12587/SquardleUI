//
//  TutorialNextButtonView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct TutorialNextButtonView: View {
    @State var isAnimating = false
    
    var body: some View {
        Button {
        } label: {
            Text("Нажмите, чтобы продолжить...")
                .foregroundColor(.gray)
                .opacity(isAnimating ? 0 : 1)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                isAnimating.toggle()
            }
        }

    }
}

struct TutorialNextButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialNextButtonView()
    }
}
