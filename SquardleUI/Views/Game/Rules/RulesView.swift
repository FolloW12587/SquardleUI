//
//  RulesView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 30.11.2022.
//

import SwiftUI

struct RulesView: View {
    var dismissAction: (() -> ())? = nil
    @State var showTutorial = false
    
    var body: some View {
        VStack {
            if dismissAction != nil {
                DismissButtonView(dismissAction: dismissAction!)
            }
            
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10){
                        
                        header
                        
                        HStack(spacing: 0) {
                            Image("grid")
                                .resizable()
                                .frame(width: geometry.size.width / 2, height: geometry.size.width / 2)
                            Text("На поле 5х5 загаданы 6 слов. Задача состоит в том, чтобы их отгадать.")
                        }
                        
                        Group {
                            Text("Как играть?")
                                .font(.title.bold())
                            
                            Text("Вводите слова из пяти букв и жмите \"Ввод\". Введенное слово появится как в столбце, так и в колонке, и по каждой букве Вы получите подсказки, о которых мы поговорим позднее.\n\nВ начале игры Вам дается 9 попыток. За каждое из первых пяти слов, для которого Вы откроете все буквы, Вы получите по дополнительной попытке. Шестое отгаданное слово принесет Вам победу! Заметьте, что необязательно вводить конкретное слово, чтобы оно считалось отгаданным, главное, открыть все буквы.")
                        }
                        
                        
                        Group {
                            Text("Как изменить куда вводить слово?")
                                .font(.title.bold())
                            
                            Text("Никак. Первое слово автоматически вводится одновременно в первую строку и колонку, второе слово в третью строку и колонку, третье в пятую и так по кругу. Вам не нужно об этом заботиться, игра сама будет менять, куда вы вводите слова. Чтобы не запутаться, текущие строки и столбцы будут подсвечены.")
                        }
                        
                        RulesHintsView(geometry: geometry)

                        RulesKeyboardView(geometry: geometry)
                        
                        RulesMarkView(geometry: geometry)
                        
                        Group {
                            Text("Подведем итоги")
                                .font(.title.bold())
                            
                            Text("В сетке загадано 6 слов, Вам дано 9 попыток со старта и еще есть возможность получить 5 дополнительных попыток, чтобы их отгадать. Проверяемое слово одновременно записывается и в строку и в столбец. Вам не нужно выбирать куда его записать, игра автоматически циклично перемещаться по рядам. Но Вы можете ставить заметки для клеток, в которых хотите попробовать букву позднее. Для того, чтобы отгадать слово, необязательно вводить непосредственно само слово, достаточно открыть все буквы.")
                            
                            Text("Это все, что Вам нужно знать! Желаю удачи!")
                                .font(.title.bold())
                        }
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
        }
        .padding(.horizontal)
        .background(ThemeModel.main.backgroundColor)
        .overlay {
            if showTutorial {
                TutorialView {
                    showTutorial.toggle()
                }
            }
        }
    }
    
    var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Вы можете заново просмотреть короткое обучение или же прочитать полные правила.")

            Button {
                showTutorial.toggle()
            } label: {
                HStack {
                    Spacer()
                    Text("Короткое обучение")
                        .padding()
                        .foregroundColor(.white)
                        .background(Capsule()
                            .fill(ThemeModel.main.tileOpenedBackgroundColor))
                    Spacer()
                }
            }

            
            Text("Правила игры")
                .font(.title.bold())
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView(){}
    }
}
