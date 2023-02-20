//
//  RulesKeyboardView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 20.02.2023.
//

import SwiftUI

struct RulesKeyboardView: View {
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Что означают цвета на клавиатуре?")
                .font(.title.bold())
            
            Text("По мере получения подсказок на поле, также будут обновляться и цвета на клавиатуре.")
            
            KeyboardKeyRuleView(state: .def, width: geometry.size.width / 7, text: " - начальный цвет, который означает, что никакой информации по этой букве на поле еще не получено.")
            
            KeyboardKeyRuleView(state: .exists, width: geometry.size.width / 7, text: " - буква присутствует хотя бы в одном из шести загаданных на поле слов.")
            
            KeyboardKeyRuleView(state: .notExists, width: geometry.size.width / 7, text: " - буквы нет ни в одном из загаданных слов на поле.")
        }
    }
}

struct RulesKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            RulesKeyboardView(geometry: geometry)
        }
    }
}
