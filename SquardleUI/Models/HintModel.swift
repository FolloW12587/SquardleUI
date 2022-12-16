//
//  HintModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 24.11.2022.
//

import Foundation
import SwiftUI

class HintModel: ObservableObject {
    @Published var isHidden: Bool
    @Published var isScaled: Bool
    
    let character: Character
    let position: CGPoint
    let state: State
    
    init(character: Character, state: State, position: CGPoint, isHidden: Bool = false, isScaled: Bool = false) {
        self.character = character
        self.state = state
        self.position = position
        self.isHidden = isHidden
        self.isScaled = isScaled
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        character = try container.decode(Character.self, forKey: .character)
        state = try container.decode(State.self, forKey: .state)
        position = try container.decode(CGPoint.self, forKey: .position)
        isHidden = false
        isScaled = false
    }
    
    convenience init(character: Character, position: CGPoint, count: Int, appears: Bool, countInRow: Int, countInColumn: Int) {
        let state: State
        if !appears {
            state = .notExists
        } else if countInRow == 0 && countInColumn == 0 {
            state = .exists
        } else {
            state = .existsInRowOrColumn(inRowCount: min(count, countInRow), inColumnCount: min(count, countInColumn))
        }
        self.init(character: character, state: state, position: position)
    }
}

extension HintModel: Codable {
    enum CodingKeys: CodingKey {
        case character, position, state
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.character, forKey: .character)
        try container.encode(self.state, forKey: .state)
        try container.encode(self.position, forKey: .position)
    }
}

extension HintModel {
    // handle actions
    
    func tapped() {
        if self.isScaled {
            self.isScaled.toggle()
            return
        }
        
        self.isHidden.toggle()
    }
    
    func longPressed() {
        self.isHidden = false
        self.isScaled = true
    }
    
    func appeared(){
        longPressed()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.isScaled = false
            }
        }
    }
}

extension HintModel {
    static let example = HintModel(character: "А", state: .exists, position: .zero)
    static let exampleHidden = HintModel(character: "А", state: .exists, position: .zero, isHidden: true)
    static let exampleScaled = HintModel(character: "А", state: .exists, position: .zero, isScaled: true)
    static let exampleNotExists = HintModel(character: "А", state: .notExists, position: .zero)
    static let exampleInRow = HintModel(character: "А", state: .existsInRowOrColumn(inRowCount: 1, inColumnCount: 0), position: .zero)
    static let exampleInColumn = HintModel(character: "А", state: .existsInRowOrColumn(inRowCount: 0, inColumnCount: 2), position: .zero)
    static let exampleInRowAndColumn = HintModel(character: "А", state: .existsInRowOrColumn(inRowCount: 3, inColumnCount: 1), position: .init(x: 0, y: 1))
}

extension HintModel {
    enum State: Equatable, Hashable, Codable {
        case notExists
        case exists
        case existsInRowOrColumn(inRowCount: Int, inColumnCount: Int)
    }
}

extension HintModel: Equatable {
    static func == (lhs: HintModel, rhs: HintModel) -> Bool {
        lhs.character == rhs.character && lhs.state == rhs.state
    }
}

extension HintModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(character)
        hasher.combine(state)
    }
}
