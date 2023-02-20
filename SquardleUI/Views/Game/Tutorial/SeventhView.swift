//
//  SeventhView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct SeventhView: View {
    var nextViewClosure: () -> ()
    var prevViewClosure: () -> ()
    @StateObject var tileModel = TileModel(character: "A", position: .zero)
    @State private var totalHeight = CGFloat(100)
    
    var body: some View {
        ZStack{
            VStack {
                DismissButtonView(dismissAction: prevViewClosure)
                    .tint(ThemeModel.main.mainForegroundColor)
                    .padding(.leading)
                
                Spacer()
                
                Text("В процессе поиска решения Вы можете начать догадываться, какие буквы скрыты в некоторых клетках. Чтобы не держать это в голове, сделайте заметку. Нажмите на клетку. Она перейдет в режим редактирования. Нажмите на букву, которую Вы предполагаете.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                
                GeometryReader { proxy in
                    HStack {
                        Spacer()
                        TileView(tileModel: tileModel)
                            .disabled(true)
                            .frame(width: proxy.size.width / 4)
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
                
                Text("У заметок есть два режима, Вы можете их использовать как индикатор того, точно ли Вы уверены, что буква правильная, или нет. Чтобы изменить режим, дважды нажмите на клетку с заметкой.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Не забывайте, Вам все еще нужно открыть букву, даже если вы ее правильно отметили!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                
                Spacer()
                TutorialNextButtonView()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: nextViewClosure)
        .onAppear(perform: startAnimation)
    }
    
    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            withAnimation{
                tileModel.clicked()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.handleCharacterForMarkingTile("А")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            withAnimation{
                tileModel.clicked()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
            withAnimation{
                tileModel.clicked()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5){
            withAnimation{
                tileModel.clicked()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5){
            self.handleCharacterForMarkingTile(" ")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 7){
            startAnimation()
        }
    }
    
    func handleCharacterForMarkingTile(_ character: Character){
        if character == " " {
            tileModel.state = .none
            tileModel.markedCharacter = nil
            return
        }
        
        tileModel.markedCharacter = character
        if tileModel.prevState == .markedSure || tileModel.prevState == .markedNotSure {
            tileModel.state = tileModel.prevState
        } else {
            tileModel.state = .markedNotSure
        }
    }
}

struct SeventhView_Previews: PreviewProvider {
    static var previews: some View {
        SeventhView{} prevViewClosure: {}
    }
}
