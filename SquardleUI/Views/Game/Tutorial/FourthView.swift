//
//  FourthView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct FourthView: View {
    var nextViewClosure: () -> ()
    var prevViewClosure: () -> ()
    @State private var totalHeight = CGFloat(100)
    
    var body: some View {
        ZStack{
            VStack {
                DismissButtonView(dismissAction: prevViewClosure)
                    .tint(ThemeModel.main.mainForegroundColor)
                    .padding(.leading)
                
                Spacer()
                Text("Так и со стрелками:")
                    .font(.title2)
                    .multilineTextAlignment(.center)

                GeometryReader { proxy in
                    VStack(alignment: .leading){
                        HintRuleView(state: .existsInRowOrColumn(inRowCount: 1, inColumnCount: 0), width: proxy.size.width / 6, text: " - буквы \"А\" нет ни в этой клетке, ни в колонке, но есть как МИНИМУМ одна где-то в этой строке. Подсказка также может указывать на уже открытую букву.")

                        HintRuleView(state: .existsInRowOrColumn(inRowCount: 0, inColumnCount: 1), width: proxy.size.width / 6, text: " - буквы \"А\" нет ни в этой клетке, ни в строке, но есть как МИНИМУМ одна где-то в этой колонке. Подсказка также может указывать на уже открытую букву.")


                        HintRuleView(state: .existsInRowOrColumn(inRowCount: 1, inColumnCount: 1), width: proxy.size.width / 6, text: " - буквы \"А\" нет в этой клетке, но есть как минимум одна где-то в этой колонке, а также минимум одна в этой строке.")
                    }
                    .frame(width: proxy.size.width)
                    .fixedSize()
                    .background(GeometryReader {gp -> Color in
                        DispatchQueue.main.async {
                            // update on next cycle with calculated height of ZStack !!!
                            self.totalHeight = gp.size.height
                        }
                        return Color.clear
                    })
                }
                .padding()
                .frame(height: totalHeight)
                
                Spacer()
                
                Text("Также есть большое множество комбинаций разного количества пар стрелок. Например, две пары стрелок в горизотальной плоскости будут означать, что есть минимум две буквы по горизонтали.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .top, .trailing])
                Spacer()
                TutorialNextButtonView()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: nextViewClosure)
    }
}

struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView{} prevViewClosure: {}
    }
}
