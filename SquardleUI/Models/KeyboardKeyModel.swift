//
//  Keyboard - KeyModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


class KeyboardKeyModel: ObservableObject, Hashable {
    static func == (lhs: KeyboardKeyModel, rhs: KeyboardKeyModel) -> Bool {
        lhs.character == rhs.character
    }
    
    @Published var state: State = .def
    let character: Character
    
    init(character: Character, state: State = .def) {
        self.character = character
        self.state = state
    }
    
    static let example = KeyboardKeyModel(character: "А")
    static let exampleExists = KeyboardKeyModel(character: "А", state: .exists)
    static let exampleNotExists = KeyboardKeyModel(character: "А", state: .notExists)
    static let deleteExample = KeyboardKeyModel(character: " ")
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(character)
    }

}

extension KeyboardKeyModel {
    enum State {
        case def
        case exists
        case notExists
    }
}
