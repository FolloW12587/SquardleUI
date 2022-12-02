//
//  Keyboard - KeyModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


class KeyboardKeyModel: ObservableObject {
    @Published var state: State = .def
    let character: Character
    
    init(character: Character, state: State = .def) {
        self.character = character
        self.state = state
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.character = try container.decode(Character.self, forKey: .character)
        self.state = try container.decode(State.self, forKey: .state)
    }
    
    static let example = KeyboardKeyModel(character: "А")
    static let exampleExists = KeyboardKeyModel(character: "А", state: .exists)
    static let exampleNotExists = KeyboardKeyModel(character: "А", state: .notExists)
    static let deleteExample = KeyboardKeyModel(character: " ")
    
}

extension KeyboardKeyModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(character)
    }
}

extension KeyboardKeyModel: Equatable {
    static func == (lhs: KeyboardKeyModel, rhs: KeyboardKeyModel) -> Bool {
        lhs.character == rhs.character
    }
}

extension KeyboardKeyModel: Codable {
    enum CodingKeys: CodingKey {
        case character, state
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.character, forKey: .character)
        try container.encode(self.state, forKey: .state)
    }
}

extension KeyboardKeyModel {
    enum State: Codable {
        case def
        case exists
        case notExists
    }
}
