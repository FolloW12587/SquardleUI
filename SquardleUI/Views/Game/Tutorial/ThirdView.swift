//
//  ThirdView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct ThirdView: View {
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
                Text("Подсказки без стрелок:")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()

                GeometryReader { proxy in
                    VStack(alignment: .leading){
                        HintRuleView(state: .exists, width: proxy.size.width / 5, text: " - буквы \"А\" нет ни в колонке, ни в строке, но она есть как минимум в одном из 6 загаданных слов.")
                        
                        HintRuleView(state: .notExists, width: proxy.size.width / 5, text: " - буквы \"А\" нет ни в одном из 6 загаданных слов.")
    
                        
                        HStack(spacing: 10) {
                            TileView(tileModel: TileModel.exampleOpened)
                                .frame(width: proxy.size.width / 5)
                                .disabled(true)
                            Text("Если вся клетка стала такой, то Вы молодец и отгадали букву! Цель игры состоит в том, чтобы все клетки стали такими!")
                        }
                    }
                    .frame(width: proxy.size.width)
                    .fixedSize()
                }
                .padding()
                .scaledToFit()
                
                Spacer()
                TutorialNextButtonView()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: nextViewClosure)
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView{} prevViewClosure: {}
            .environmentObject(ThemeModel())
    }
}
