//
//  EightView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct EightView: View {
    @EnvironmentObject var theme: ThemeModel
    var nextViewClosure: () -> ()
    var prevViewClosure: () -> ()
    
    var body: some View {
        ZStack{
            VStack {
                DismissButtonView(dismissAction: prevViewClosure)
                    .tint(theme.mainForegroundColor)
                    .padding(.leading)
                Spacer()
                Text("Это все, что Вам необходимо знать!")
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
        .contentShape(Rectangle())
        .onTapGesture(perform: nextViewClosure)
    }
}

struct EightView_Previews: PreviewProvider {
    static var previews: some View {
        EightView{} prevViewClosure: {}
            .environmentObject(ThemeModel())
    }
}
