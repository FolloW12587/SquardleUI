//
//  ThemeModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

class ThemeModel: ObservableObject {
    @Published var backgroundColor = Color.init(red: 244 / 255, green: 241 / 255, blue: 236 / 255)
    @Published var mainColor = Color.init(red: 226 / 255, green: 149 / 255, blue: 67 / 255)
    @Published var tileMainBackgroundColor = Color.init(white: 0.8)
    @Published var tileMarkedBackgroundColor = Color.init(white: 0.8)
    @Published var tileOpenedBackgroundColor = Color.init(red: 79 / 255, green: 154 / 255, blue: 105 / 255)
    @Published var tileEdittingBackgroundColor = Color.init(red: 0.3, green: 0.3, blue: 0.5)
    @Published var notExistsColor = Color.init(white: 0.27)
    @Published var existsColor = Color.white
    @Published var existsInRowColor = Color.yellow
    @Published var existsInColumnColor = Color.indigo
    @Published var existsInRowAndColumnColor = Color.cyan

    @Published var mainForegroundColor = Color.black
    @Published var secondaryForegroundColor = Color.init(white: 0.8)
    @Published var activeForegroundColor = Color.white
    @Published var notExistsForegroundColor = Color.white
    @Published var existsForegroundColor = Color.black
    @Published var existsInRowForegroundColor = Color.black
    @Published var existsInColumnForegroundColor = Color.white
    @Published var existsInRowAndColumnForegroundColor = Color.white

    
    func switchTheme(scheme: ColorScheme){
        if scheme == .dark {
            backgroundColor = ThemeModel.darkBackgroundColor
        } else {
            backgroundColor = ThemeModel.lightBackgroundColor
        }
    }
    
    static let lightBackgroundColor = Color.init(red: 244 / 255, green: 241 / 255, blue: 236 / 255)
    static let darkBackgroundColor = Color.init(white: 0.27)
}
