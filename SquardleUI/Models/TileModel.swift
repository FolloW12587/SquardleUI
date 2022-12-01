//
//  TileModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation

class TileModel: ObservableObject {
    @Published var tempCharacter: Character? = nil
    @Published var markedCharacter: Character? = nil
    @Published var state: TileState
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
    
    var prevState = TileState.none
    var emptyHintPositions = [CGPoint]()
    
    let character: Character
    let position: CGPoint
    
    
    var isOpened: Bool {
        state == .opened
    }
    
    init(character: Character, position: CGPoint, state: TileState = .none, markedCharacter: Character? = nil, isOnGuessingWay: Bool = false, hints: [HintModel] = []){
        self.character = character
        self.position = position
        self.state = state
        self.markedCharacter = markedCharacter
        self.isOnGuessingWay = isOnGuessingWay
        self.hints = hints
        createEmptyHintPositions()
    }
    
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
        
        if hints.contains(hint) {
            emptyHintPositions.append(newHintPosition)
            return
        }
        
        hints.append(hint)
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

extension TileModel {
    enum TileState {
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
