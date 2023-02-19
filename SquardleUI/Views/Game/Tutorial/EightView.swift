//
//  EightView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct EightView: View {
    var nextViewClosure: () -> ()
    var prevViewClosure: () -> ()
    
    var body: some View {
        ZStack{
            ThemeModel.main.backgroundColor.ignoresSafeArea()
            
            VStack {
                DismissButtonView(dismissAction: prevViewClosure)
                    .tint(ThemeModel.main.mainForegroundColor)
                    .padding(.leading)
                Spacer()
                Text("Это все, что вам необходимо знать!")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Желаю удачи!")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                Spacer()
                TutorialNextButtonView()
            }
        }
        .onTapGesture(perform: nextViewClosure)
    }
}

struct EightView_Previews: PreviewProvider {
    static var previews: some View {
        EightView{} prevViewClosure: {}
    }
}
