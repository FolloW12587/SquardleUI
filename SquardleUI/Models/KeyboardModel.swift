//
//  KeyboardModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation

class KeyboardModel {
    var firstRow: [KeyboardKeyModel]
    var secondRow: [KeyboardKeyModel]
    var thirdRow: [KeyboardKeyModel]
    
    var keys: [KeyboardKeyModel] {
        firstRow + secondRow + thirdRow
    }
    
    init() {
        let firstRowCharacters = "ЙЦУКЕНГШЩЗХЪ"
        let secondRowCharacters = "ФЫВАПРОЛДЖЭ"
        let thirdRowCharacters = "ЯЧСМИТЬБЮ "
        
        
        self.firstRow = firstRowCharacters.map{ KeyboardKeyModel(character: $0) }
        self.secondRow = secondRowCharacters.map{ KeyboardKeyModel(character: $0) }
        self.thirdRow = thirdRowCharacters.map{ KeyboardKeyModel(character: $0) }
    }
}
