//
//  RulesHintsView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 20.02.2023.
//

import SwiftUI

struct RulesHintsView: View {
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Какие бывают подсказки?")
                .font(.title.bold())
            
            HintRuleView(state: .exists, width: geometry.size.width / 5, text: " - буквы \"А\" нет ни в колонке, ни в строке, но она есть как минимум в одном из 6 загаданных слов.")
            
            HintRuleView(state: .notExists, width: geometry.size.width / 5, text: " - буквы \"А\" нет ни в одном из 6 загаданных слов.")
            
            HintRuleView(state: .existsInRowOrColumn(inRowCount: 1, inColumnCount: 0), width: geometry.size.width / 5, text: " - буквы \"А\" нет ни в этой клетке, ни в колонке, но есть как МИНИМУМ одна где-то в этой строке. Подсказка также может указывать на уже открытую букву.")
            
            HintRuleView(state: .existsInRowOrColumn(inRowCount: 0, inColumnCount: 1), width: geometry.size.width / 5, text: " - буквы \"А\" нет ни в этой клетке, ни в строке, но есть как МИНИМУМ одна где-то в этой колонке. Подсказка также может указывать на уже открытую букву.")
            
            
            HintRuleView(state: .existsInRowOrColumn(inRowCount: 2, inColumnCount: 1), width: geometry.size.width / 5, text: " - буквы \"А\" нет в этой клетке, но есть как минимум одна где-то в этой колонке, а также минимум две в этой строке.")
            
            HStack(spacing: 10) {
                TileView(tileModel: TileModel.exampleOpened)
                    .frame(width: geometry.size.width / 5)
                    .disabled(true)
                Text("Если вся клетка стала такой, то Вы молодец и отгадали букву! Цель игры состоит в том, чтобы все клетки стали такими!")
            }
            
            Text("Как Вы уже поняли, у каждого цвета свое значение. Не запутаться Вам помогут стрелочки подсказки.\n\nВозможно, Вы заметили, что даже если в слове несколько раз встречается одна и та же буква, это не значит, что подсказка с ней будет с несколькими парами стрелок. Чтобы подсказка имела несколько пар стрелок, нужно, чтобы в проверяемое тоже входила эта буква несколько раз.\n\nНапример, пусть в сетке загадано слово \"ОЛОВО\", в которой 3 буквы \"О\". Если вводимое Вами слово будет \"КОТЕЛ\", то подсказка \"О\" будет с одной парой стрелок. Если вводимое Вами слово будет \"РОТОР\", то подсказка \"О\" будет иметь 2 пары стрелок и т.д. Если же, наоборот, загадано слово \"КОТЕЛ\", а вводимое Вами слово \"РОТОР\", то подсказка будет с одной парой стрелок. Это значит, что в загаданном слове точно только одна буква \"О\".")
            
            Group {
                Text("Как увеличить или уменьшить подсказки?")
                    .font(.title.bold())
                
                Text("В течении игры Вы будете получать все больше и больше подсказок, но мы ограничены размерами экрана, чтобы уместить их всех в удобном формате. В случае, если у Вас есть затруднения в чтении подсказки, нажмите на нее и подержите пару секунд. Она раскроется на всю клетку. Чтобы вернуть все как было, просто нажмите на нее.\n\nТакже подсказок может становиться много, они могут начать дублировать друг-друга или дополнять. Чтобы не отвлекаться на такие подсказки, Вы можете скрыть их, нажав на них. Чтобы снова их посмотреть, нажмите на сокрытую подсказку снова.\n\nПопробовать как это работает Вы можете на интерактивной подсказке ниже.")
                
                HStack {
                    Spacer()
                    GeometryReader { geo in
                        HintView(hintModel: HintModel.exampleInRowAndColumn, width: geo.size.width, position: CGPoint(x: geo.size
                            .width / 2, y: geo.size.width / 2))
                        
                    }
                    .frame(width: geometry.size
                        .width / 2, height: geometry.size
                    .width / 2)
                    Spacer()
                }
            }
        }
    }
}

struct RulesHintsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            RulesHintsView(geometry: geometry)
        }
    }
}
