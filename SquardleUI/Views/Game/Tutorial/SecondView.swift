//
//  SecondView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct SecondView: View {
    @StateObject var gameModel = GameModel(boardModel: BoardModel(words: BoardModel.exampleWords), words: BoardModel.exampleWords)
    var nextViewClosure: () -> ()
    var prevViewClosure: () -> ()
    @State private var totalHeight = CGFloat(300)
    
    var body: some View {
        ZStack{
            VStack {
                DismissButtonView(dismissAction: prevViewClosure)
                    .tint(ThemeModel.main.mainForegroundColor)
                    .padding(.leading)
                
                Spacer()
                Text("На поле загададано 6 слов. Чтобы их отгадать, вводите слова из 5 букв и получайте подсказки.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack {
                    Spacer()
                    BoardView(boardModel: gameModel.board)
                        .disabled(true)
                    Spacer()
                }
                Spacer()
                
                Text("Первое слово одновременно вводится в колонку и столбец. Затем ввод автоматически сменится на 3 колонку и 3 столбец, затем на 5 и так по кругу. Текущие строки подсвечиваются.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                TutorialNextButtonView()
            }
        }
        .onAppear{
            startAnimation()
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: nextViewClosure)
    }
    
    func startAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            gameModel.keyTapped(KeyboardKeyModel(character: "З"))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            gameModel.keyTapped(KeyboardKeyModel(character: "А"))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            gameModel.keyTapped(KeyboardKeyModel(character: "Б"))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            gameModel.keyTapped(KeyboardKeyModel(character: "О"))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            gameModel.keyTapped(KeyboardKeyModel(character: "Р"))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6){
            gameModel.guessWord()
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView{} prevViewClosure: {}
    }
}
