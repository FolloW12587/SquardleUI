//
//  FirstView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct FirstView: View {
    var nextViewClosure: () -> ()
    
    var body: some View {
        ZStack{
            ThemeModel.main.backgroundColor.ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Добро пожаловать в \"Шесть Слов\"!")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Давайте я научу Вас играть!")
                    .font(.title2)
                Spacer()
                TutorialNextButtonView()
            }
        }
        .onTapGesture(perform: nextViewClosure)
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(){}
    }
}
