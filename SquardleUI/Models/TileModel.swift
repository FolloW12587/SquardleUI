//
//  TileModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation

class TileModel: ObservableObject {
    @Published var tempCharacter: Character? = nil {
        didSet {
            hideAllScaledHints()
        }
    }
    @Published var showSolution: Bool = false
    @Published var markedCharacter: Character? = nil
    @Published var state: State
    @Published var isOnGuessingWay: Bool = false
    @Published var hints: [HintModel] = []
    @Published var wrongGuessedWord: Bool = false {
        didSet {
            if wrongGuessedWord {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.wrongGuessedWord = false
                }
            }
        }
    }
    
    var prevState = State.none
    var emptyHintPositions = [CGPoint]()
    
    let character: Character
    let position: CGPoint
    
    
    var isOpened: Bool {
        state == .opened
    }
    
    init(character: Character, position: CGPoint, state: State = .none, markedCharacter: Character? = nil, isOnGuessingWay: Bool = false, hints: [HintModel] = []){
        self.character = character
        self.position = position
        self.state = state
        self.markedCharacter = markedCharacter
        self.isOnGuessingWay = isOnGuessingWay
        self.hints = hints
        createEmptyHintPositions()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        character = try container.decode(Character.self, forKey: .character)
        state = try container.decode(State.self, forKey: .state)
        position = try container.decode(CGPoint.self, forKey: .position)
        markedCharacter = try container.decode(Character?.self, forKey: .markedCharacter)
        hints = try container.decode([HintModel].self, forKey: .hints)
        emptyHintPositions = try container.decode([CGPoint].self, forKey: .emptyHintPositions)
    }
    
    func createEmptyHintPositions() {
        self.emptyHintPositions = []
        for i in 0..<(16) {
            if [5, 6, 9, 10].contains(i){
                continue
            }
            
            let x: Int = i % 4
            let y: Int = i / 4
            self.emptyHintPositions.append(CGPoint(x: x, y: y))
        }
    }
    
    func hideAllScaledHints() {
        hints.forEach { hint in
            if hint.isScaled {
                hint.isScaled = false
            }
        }
    }
}

extension TileModel {
    // handle actions
    
    func clicked() {
        if state == .opened {
            return
        }
        
        if state != .editting {
            prevState = state
            state = .editting
            return
        }
        
        switch prevState {
        case .none:
            state = .none
            return
        case .markedSure:
            state = .markedNotSure
            return
        case .markedNotSure:
            state = .markedSure
            return
        default:
            return
        }
    }
    
    func guessCharacter(_ character: Character, count: Int, appears: Bool, countInRow: Int, countInColumn: Int) {
        tempCharacter = nil
        hideAllScaledHints()
        
        if self.character == character {
            self.state = .opened
            return
        }
        
        if markedCharacter != nil && markedCharacter == character {
            markedCharacter = nil
            self.state = .none
        }
        
        guard let newHintPosition = emptyHintPositions.removeRandom() else {
            print("Have not empty position for new hint!")
            return
        }
        
        let hint = HintModel(character: character, position: newHintPosition, count: count, appears: appears, countInRow: countInRow, countInColumn: countInColumn)
        
        if let existingHint = hints.filter({ $0 == hint }).first {
            emptyHintPositions.append(newHintPosition)
            existingHint.appeared()
            return
        }
        
        hints.append(hint)
    }
}

extension TileModel {
    
    static let example = TileModel(character: "А", position: .zero)
    static let exampleWithHints = TileModel(character: "А", position: .zero, state: .opened, hints: [HintModel.example, HintModel.exampleInRowAndColumn])
    static let exampleOnGuessingWay = TileModel(character: "А", position: .zero, isOnGuessingWay: true)
    static let exampleEditting = TileModel(character: "А", position: .zero, state: .editting)
    static let exampleOpened = TileModel(character: "А", position: .zero, state: .opened)
    static let exampleMarkedSure = TileModel(character: "А", position: .zero, state: .markedSure, markedCharacter: "А")
    static let exampleMarkedNotSure = TileModel(character: "А", position: .zero, state: .markedNotSure, markedCharacter: "А")
    
}

extension TileModel: Codable {
    enum CodingKeys: CodingKey {
        case character, position, state, hints, markedCharacter, emptyHintPositions
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.character, forKey: .character)
        try container.encode(self.state, forKey: .state)
        try container.encode(self.hints, forKey: .hints)
        try container.encode(self.position, forKey: .position)
        try container.encode(self.markedCharacter, forKey: .markedCharacter)
        try container.encode(self.emptyHintPositions, forKey: .emptyHintPositions)
    }
}

extension TileModel {
    enum State: Codable {
        case none
        case editting
        case markedSure
        case markedNotSure
        case opened
    }
}

extension TileModel: Equatable{
    static func == (lhs: TileModel, rhs: TileModel) -> Bool {
        return lhs.position == rhs.position
    }
}
