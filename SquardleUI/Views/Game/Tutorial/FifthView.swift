//
//  FifthView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct FifthView: View {
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
                
                Text("Чтобы подсказка имела несколько пар стрелок, нужно, чтобы в проверяемое тоже входила эта буква несколько раз.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Например, пусть в сетке загадано слово \"ОЛОВО\", в которой 3 буквы \"О\". Если вводимое Вами слово будет \"КОТЕЛ\", то подсказка \"О\" будет с одной парой стрелок. Если вводимое Вами слово будет \"РОТОР\", то подсказка \"О\" будет иметь 2 пары стрелок и т.д. Если же, наоборот, загадано слово \"КОТЕЛ\", а вводимое Вами слово \"РОТОР\", то подсказка будет с одной парой стрелок. Это значит, что в загаданном слове точно только одна буква \"О\".")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                TutorialNextButtonView()
            }
        }
        .onTapGesture(perform: nextViewClosure)
    }
}

struct FifthView_Previews: PreviewProvider {
    static var previews: some View {
        FifthView{} prevViewClosure: {}
    }
}
