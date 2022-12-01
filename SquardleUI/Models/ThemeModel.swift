//
//  ThemeModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI

class ThemeModel {
    let backgroundColor: Color
    let mainColor: Color
    
    let tileMainBackgroundColor: Color
    let tileMarkedBackgroundColor: Color
    let tileOpenedBackgroundColor: Color
    let tileEdittingBackgroundColor: Color
    
    let notExistsColor: Color
    let existsColor: Color
    let existsInRowColor: Color
    let existsInColumnColor: Color
    let existsInRowAndColumnColor: Color
    
    let mainForegroundColor: Color
    let secondaryForegroundColor: Color
    let activeForegroundColor: Color
    let notExistsForegroundColor: Color
    let existsForegroundColor: Color
    let existsInRowForegroundColor: Color
    let existsInColumnForegroundColor: Color
    let existsInRowAndColumnForegroundColor: Color
    
    
    init(backgroundColor: Color, mainColor: Color, tileMainBackgroundColor: Color, tileOpenedBackgroundColor: Color, tileEdittingBackgroundColor: Color, notExistsColor: Color, existsColor: Color, existsInRowColor: Color, existsInColumnColor: Color, existsInRowAndColumnColor: Color, mainForegroundColor: Color, secondaryForegroundColor: Color, activeForegroundColor: Color, notExistsForegroundColor: Color, existsForegroundColor: Color, existsInRowForegroundColor: Color, existsInColumnForegroundColor: Color, existsInRowAndColumnForegroundColor: Color) {
        self.backgroundColor = backgroundColor
        self.mainColor = mainColor
        
        self.tileMainBackgroundColor = tileMainBackgroundColor
        self.tileMarkedBackgroundColor = mainColor
        self.tileOpenedBackgroundColor = tileOpenedBackgroundColor
        self.tileEdittingBackgroundColor = tileEdittingBackgroundColor
        
        self.notExistsColor = notExistsColor
        self.existsColor = existsColor
        self.existsInRowColor = existsInRowColor
        self.existsInColumnColor = existsInColumnColor
        self.existsInRowAndColumnColor = existsInRowAndColumnColor
        
        self.mainForegroundColor = mainForegroundColor
        self.secondaryForegroundColor = secondaryForegroundColor
        self.activeForegroundColor = activeForegroundColor
        self.notExistsForegroundColor = notExistsForegroundColor
        self.existsForegroundColor = existsForegroundColor
        self.existsInRowForegroundColor = existsInRowForegroundColor
        self.existsInColumnForegroundColor = existsInColumnForegroundColor
        self.existsInRowAndColumnForegroundColor = existsInRowAndColumnForegroundColor
    }
    
    static let main = ThemeModel(backgroundColor: .init(red: 244 / 255, green: 241 / 255, blue: 236 / 255),
                                 mainColor: .init(red: 226 / 255, green: 149 / 255, blue: 67 / 255),
                                 tileMainBackgroundColor: .init(white: 0.8),
                                 tileOpenedBackgroundColor: .init(red: 79 / 255, green: 154 / 255, blue: 105 / 255),
                                 tileEdittingBackgroundColor: .init(red: 0.3, green: 0.3, blue: 0.5),
//                                 keyExistsColor: Color.init(red: 230 / 255, green: 30 / 255, blue: 230 / 255),
                                 notExistsColor: .init(white: 0.27),
                                 existsColor: .white,
                                 existsInRowColor: .yellow,
                                 existsInColumnColor: .indigo,
                                 existsInRowAndColumnColor: .cyan,
                                 
                                 mainForegroundColor: .black,
                                 secondaryForegroundColor: .init(white: 0.8),
                                 activeForegroundColor: .white,
                                 notExistsForegroundColor: .white,
                                 existsForegroundColor: .black,
                                 existsInRowForegroundColor: .black,
                                 existsInColumnForegroundColor: .white,
                                 existsInRowAndColumnForegroundColor: .white
                                 )
}
