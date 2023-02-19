//
//  SixthView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct SixthView: View {
    var nextViewClosure: () -> ()
    var prevViewClosure: () -> ()
    @State private var totalHeight = CGFloat(100)
    
    var body: some View {
        ZStack{
            ThemeModel.main.backgroundColor.ignoresSafeArea()
            
            VStack {
                DismissButtonView(dismissAction: prevViewClosure)
                    .tint(ThemeModel.main.mainForegroundColor)
                    .padding(.leading)
                
                Spacer()
                
                Text("В ходе игры Вы будете получать мого подсказок, и чтобы уместить их всех на экране, пришлось сделать их достаточно маленькими. Чтобы увеличить подсказку, зажмите и подержите палец на ней пару сеукунд. Чтобы вернуть ее к исходному размеру нажмите на нее. Попробуйте ниже:")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                GeometryReader { proxy in
                    HStack {
                        Spacer()
                            HintView(hintModel: HintModel.exampleInRowAndColumn, width: proxy.size.width/2, position: CGPoint(x: proxy.size
                                .width / 4, y: proxy.size.width / 4))
                                    .frame(width: proxy.size.width / 2, height: proxy.size.width / 2)
                        Spacer()
                    }
                    .background(GeometryReader {gp -> Color in
                        DispatchQueue.main.async {
                            // update on next cycle with calculated height of ZStack !!!
                            self.totalHeight = gp.size.height
                        }
                        return Color.clear
                    })
                }
                .frame(height: totalHeight)
                
                Text("Также вы можете уменьшить подсказку, чтобы она Вас не отвлекала. Для этого нажмите на нее. Чтобы раскрыть скрытую подсказку, снова нажмите на нее.")
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

struct SixthView_Previews: PreviewProvider {
    static var previews: some View {
        SixthView{} prevViewClosure: {}
    }
}
