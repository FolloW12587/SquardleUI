//
//  FirstView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct FirstView: View {
    var nextViewClosure: () -> ()
    @State var isAnimating = false
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                Image("logo")
                
                if isAnimating{
                    VStack {
                        Text("Добро пожаловать в \"Шесть Слов\"!")
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.center)
                        .padding()
                        
                        Text("Давайте я научу Вас играть!")
                            .font(.title2)
                    }
                    .opacity(isAnimating ? 1 : 0)
                    
                }
                
                Spacer()
                TutorialNextButtonView()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: nextViewClosure)
        .onAppear{
            withAnimation(.easeInOut(duration: 1).delay(0.5)) {
                isAnimating.toggle()
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(){}
    }
}
