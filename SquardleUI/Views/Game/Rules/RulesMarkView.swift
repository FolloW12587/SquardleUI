//
//  RulesMarkView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 20.02.2023.
//

import SwiftUI

struct RulesMarkView: View {
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Что если я знаю или предполагаю какая буква должна быть в клетке?")
                .font(.title.bold())
            
            Text("Вы можете делать заметки в клетках. Для этого нажмите на клетку. Она должна перейти в режим редактирования, как показано ниже.")
            
            HStack {
                Spacer()
                TileView(tileModel: TileModel.exampleEditting)
                    .frame(width: geometry.size.width / 4)
                    .disabled(true)
                Spacer()
            }
            
            Text("В режиме редактирования нажмите на предполагаемую букву на клавиатуре. Тем самым Вы поставите заметку в клетке. Есть два типа заметок. Если Вы нажмете дважды по клетке, то увидите, как меняется цвет буквы в ней. Это сделано для того, чтобы Вы могли обозначить, уверены ли Вы в этой букве или сомневаетесь. Выбор остается за Вами, какой из типов что будет обозначать.")
            
            HStack {
                Spacer()
                TileView(tileModel: TileModel.exampleMarkedNotSure)
                    .frame(width: geometry.size.width / 4)
                    .disabled(true)
                Spacer()
                TileView(tileModel: TileModel.exampleMarkedSure)
                    .frame(width: geometry.size.width / 4)
                    .disabled(true)
                Spacer()
            }
            
            Text("Не стоит забывать, что даже не смотря на то, что Вы пометили клетку правильной буквой, ее все равно нужно открыть!")
        }
    }
}

struct RulesMarkView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            RulesMarkView(geometry: geometry)
        }
    }
}
