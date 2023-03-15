//
//  GameModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import Foundation


class GameModel: ObservableObject, Identifiable {
    let id: UUID
    var words: [String]
    
    var board: BoardModel
    var keyboard: KeyboardModel
    var guiModel: GameGUIModel
    let mode: GameMode
    var stats: StatsModel? = nil
    
    var guessesLeft: Int {
        didSet {
            guiModel.guessesLeft = guessesLeft
        }
    }
    var guessesUsed: Int
    var currentWord = [Character]() {
        didSet {
            if currentWord.count == 5 && !guiModel.isSubmitButtonActive {
                guiModel.isSubmitButtonActive = true
            } else if currentWord.count != 6 && guiModel.isSubmitButtonActive {
                guiModel.isSubmitButtonActive = false
            }
        }
    }
    
    @Published var showSolution: Bool = false {
        didSet {
            board.showSolution()
        }
    }
    @Published var isGameOver: Bool = false{
        didSet {
            if isGameOver {
                showEndView = true
                self.gameLost()
            }
        }
    }
    @Published var isGameWon: Bool = false {
        didSet {
            if isGameWon {
                showEndAnimation = true
                self.gameWon()
            }
        }
    }
    
    @Published var showEndView: Bool = false {
        didSet {
            if showEndView {
                if isGameWon && AppReviewRequest.isRequestNeeded() {
                    AppReviewRequest.requestReview()
                } else {
                    showAdd = true
                }
            }
        }
    }
    
    var showPreEndClosure: (() -> ())!
    @Published var showPreEndView: Bool = false{
        didSet {
            if !showPreEndView && oldValue {
                if guessesLeft != 0 {
                    rotateCurrentRow()
                    saveGame()
                    return
                }
                
                isGameOver = true
            }
            
        }
    }
    var usedRewardAdd: Bool = false
    
    @Published var showEndAnimation: Bool = false {
        didSet {
            board.showEndAnimation()
            if showEndAnimation {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.showEndAnimation = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showEndView = true
                }
            }
        }
    }
    
    var currentRow: Int = 0 {
        didSet {
            unhighlightTiles()
            highlightGuessingWay()
        }
    }
    
    var currentMarkingTile: TileModel? = nil
    var distinctCharsExists: Set<Character> = []
    
    @Published var showAdd: Bool = false
    
    init(mode gameMode: GameMode = .normal) {
        id = UUID()
        self.mode = gameMode
        switch gameMode{
        case .normal:
            guessesLeft = 9
            words = dictionary.generateWords(mode: gameMode)
        case .hard:
            guessesLeft = 7
            words = dictionary.generateWords(mode: gameMode)
        }
        guessesUsed = 0
        board = BoardModel(words: words)
        keyboard = KeyboardModel()
        guiModel = GameGUIModel(guessesLeft: guessesLeft)
        
        highlightGuessingWay()
        updateDistinctCharactersExists()
        print("Gamemodel \(id) created")
    }
    
    init(boardModel: BoardModel, words: [String]) {
        id = UUID()
        self.mode = .normal
        board = boardModel
        self.words = words
        keyboard = KeyboardModel()
        guessesLeft = 9
        guiModel = GameGUIModel(guessesLeft: guessesLeft)
        guessesUsed = 0
        highlightGuessingWay()
        updateDistinctCharactersExists()
        print("Gamemodel \(id) created")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        mode = try container.decode(GameMode.self, forKey: .mode)
        words = try container.decode([String].self, forKey: .words)
        board = try container.decode(BoardModel.self, forKey: .board)
        keyboard = try container.decode(KeyboardModel.self, forKey: .keyboard)
        guessesLeft = try container.decode(Int.self, forKey: .guessesLeft)
        guessesUsed = try container.decode(Int.self, forKey: .guessesUsed)
        currentRow = try container.decode(Int.self, forKey: .currentRow)
        usedRewardAdd = try container.decode(Bool.self, forKey: .usedRewardAdd)
        guiModel = GameGUIModel(guessesLeft: guessesLeft)
        
        highlightGuessingWay()
        updateDistinctCharactersExists()
        print("Gamemodel \(id) loaded")
    }
    
    deinit {
        print("Gamemodel \(id) destroyed")
    }
}

extension GameModel: Codable {
    enum CodingKeys: CodingKey {
        case id, words, board, keyboard, guessesLeft, currentRow, mode, usedRewardAdd, guessesUsed
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.words, forKey: .words)
        try container.encode(self.board, forKey: .board)
        try container.encode(self.keyboard, forKey: .keyboard)
        try container.encode(self.guessesLeft, forKey: .guessesLeft)
        try container.encode(self.guessesUsed, forKey: .guessesUsed)
        try container.encode(self.currentRow, forKey: .currentRow)
        try container.encode(self.mode, forKey: .mode)
        try container.encode(self.usedRewardAdd, forKey: .usedRewardAdd)
    }
}

extension GameModel: Equatable {
    static func == (_ lhs: GameModel, _ rhs: GameModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension GameModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension GameModel {
    // actions handlers
    
    func keyTapped(_ key: KeyboardKeyModel){
        if isGameWon || isGameOver {
            return
        }
        
        if self.currentMarkingTile != nil {
            handleCharacterForMarkingTile(key.character)
            return
        }
        
        if key.character == " " {
            deleteCharacter()
            return
        }
        
        newCharacter(key.character)
    }
    
    func tileTapped(_ tile: TileModel) {
        if isGameWon || isGameOver {
            return
        }
        
        if tile.state == .opened {
            return
        }
        
        if let currentMarkingTile = self.currentMarkingTile {
            if currentMarkingTile != tile {
                currentMarkingTile.state = currentMarkingTile.prevState
                self.currentMarkingTile = tile
                return
            }
            self.currentMarkingTile = .none
            return
        }
        
        self.currentMarkingTile = tile
    }
    
    func submitWord() {
        if isGameWon || isGameOver {
            return
        }
        
        if currentWord.count != 5 {
            return
        }
        
        if !dictionary.wordExists(word: String(currentWord)) {
            let tilesOnWay = board.getTilesOnGuessingWay(index: currentRow)
            tilesOnWay.forEach { tile in
                tile.wrongGuessedWord = true
            }
            playSound("wrong_word")
            return
        }
        
        let wordsOpenedIndexes = board.getOpenedWordsIndexes()
        guessWord()
        endGuess(wordsOpenedBefore: wordsOpenedIndexes)
    }
    
}

extension GameModel {
    // game end checkers
    
    func checkForGameEnd() -> Bool{
        if checkForGameWin() {
            return true
        }
        return checkForGameOver()
    }
    
    func checkForGameOver() -> Bool {
        if guessesLeft <= 0 {
            if usedRewardAdd {
                isGameOver = true
            } else {
                showPreEndView = true
            }
            return true
        }
        
        return false
    }
    
    func checkForGameWin() -> Bool {
        if board.isSolved() {
            isGameWon = true
            return true
        }
        
        return false
    }
}

extension GameModel {
    // character handler funcs
    
    func deleteCharacter() {
        if currentWord.count == 0{
            return
        }
        
        _ = currentWord.popLast()
        let i = currentWord.count
        
        let firstTile = board.getTile(at: CGPoint(x: currentRow, y: i))
        let secondTile = board.getTile(at: CGPoint(x: i, y: currentRow))
        DispatchQueue.main.async {
            firstTile?.tempCharacter = nil
            secondTile?.tempCharacter = nil
        }
    }
    
    func newCharacter(_ character: Character) {
        if currentWord.count >= 5 {
            return
        }
        
        let i = currentWord.count
        currentWord.append(character)
        
        let firstTile = board.getTile(at: CGPoint(x: currentRow, y: i))
        let secondTile = board.getTile(at: CGPoint(x: i, y: currentRow))
        DispatchQueue.main.async {
            firstTile?.tempCharacter = character
            secondTile?.tempCharacter = character
        }
    }
    
    func handleCharacterForMarkingTile(_ character: Character){
        guard let currentMarkingTile = self.currentMarkingTile else {
            return
        }
        
        if character == " " {
            currentMarkingTile.markedCharacter = nil
            currentMarkingTile.state = .none
            self.currentMarkingTile = nil
            saveGame()
            return
        }
        
        currentMarkingTile.markedCharacter = character
        if currentMarkingTile.prevState == .markedSure || currentMarkingTile.prevState == .markedNotSure {
            currentMarkingTile.state = currentMarkingTile.prevState
        } else {
            currentMarkingTile.state = .markedNotSure
        }
        
        self.currentMarkingTile = nil
        saveGame()
    }
    
    
}

extension GameModel {
    // row rotation
    
    func rotateCurrentRow() {
        if isGameWon || isGameOver {
            return
        }
        var currentRow = self.currentRow
        while true {
            currentRow = (currentRow + 2) % 6
            
            let tiles = board.getTilesOnGuessingWay(index: currentRow)
            if !tiles.reduce(true, { partialResult, tile in
                partialResult && tile.isOpened
            }) {
                self.currentRow = currentRow
                return
            }
        }
    }
    
    func highlightGuessingWay() {
        let tilesToHighlight = board.getTilesOnGuessingWay(index: currentRow)
        tilesToHighlight.forEach { tile in
            tile.isOnGuessingWay = true
        }
    }
    
    func unhighlightTiles() {
        board.tiles.forEach { tile in
            tile.isOnGuessingWay = false
        }
    }
}

extension GameModel {
    
    func endGuess(wordsOpenedBefore: [Int]) {
        let wordsOpenedIndexes = board.getOpenedWordsIndexes()
        let wordsOpenedCount = (wordsOpenedIndexes.count - wordsOpenedBefore.count)
        
        if wordsOpenedCount > 0 && wordsOpenedIndexes.count < 6 {
            var indexesToAnimate = [Int]()
            for index in wordsOpenedIndexes {
                if !wordsOpenedBefore.contains(index) {
                    indexesToAnimate.append(index)
                }
            }
            
            for index in indexesToAnimate {
                board.animateWordByIndex(index)
            }
        }
        
        updateKeyboardStats()
        guessesLeft = guessesLeft - 1 + wordsOpenedCount
        guessesUsed += 1
        currentWord = []
        
        if wordsOpenedCount > 0 {
            playSound("word_opened")
        } else {
            playSound("word_guessed")
        }
        
        if checkForGameEnd() {
            return
        }
        
        rotateCurrentRow()
        saveGame()
    }
    
    func guessWord() {
        if currentWord.count != 5 {
            return
        }
        
        for i in 0..<5 {
            let character = currentWord[i]
            let countOfCharacterInWord = currentWord.filter({$0 == character}).count
            let inRowAppearance = getCharacterAppearance(character, index: i, isInRow: true)
            
            let tile1 = board.getTile(at: CGPoint(x: i, y: currentRow))
            tile1?.guessCharacter(character, count: countOfCharacterInWord, appears: inRowAppearance.appears, countInRow: inRowAppearance.countInRow, countInColumn: inRowAppearance.countInColumn)
            
            if i == currentRow {
                continue
            }
            
            let inColumnAppearance = getCharacterAppearance(character, index: i, isInRow: false)
            
            let tile2 = board.getTile(at: CGPoint(x: currentRow, y: i))
            tile2?.guessCharacter(character, count: countOfCharacterInWord, appears: inColumnAppearance.appears, countInRow: inColumnAppearance.countInRow, countInColumn: inColumnAppearance.countInColumn)
        }
    }
    
    func getCharacterAppearance(_ character: Character, index: Int, isInRow: Bool) -> (appears: Bool, countInRow: Int, countInColumn: Int) {
        let appears = distinctCharsExists.contains(character)
        
        var countInRow = 0
        var countInColumn = 0
        if appears {
            for j in 0..<5 {
                let tileRow = board.getTile(at: CGPoint(x: j, y: isInRow ? currentRow : index))
                if tileRow != nil && tileRow!.character == character {
                    countInRow += 1
                }
                
                let tileColumn = board.getTile(at: CGPoint(x:  isInRow ? index : currentRow, y: j))
                if tileColumn != nil && tileColumn!.character == character {
                    countInColumn += 1
                }
            }
        }
        return (appears: appears, countInRow: countInRow, countInColumn: countInColumn)
    }
    
    func updateKeyboardStats(){
        for character in currentWord {
            guard let key = keyboard.keys.filter({ $0.character == character }).first else {
                continue
            }
            
            key.state = distinctCharsExists.contains(character) ? .exists : .notExists
        }
    }
    
    func updateDistinctCharactersExists() {
        distinctCharsExists = words.reduce(Set<Character>(), { partialResult, word in
            partialResult.union(Set(word))
        })
    }
}

extension GameModel {
    func saveGame() {
        Task {
            FileManager.saveGame(self)
        }
    }
    
    func gameWon() {
        Task{
            stats?.gameWon()
        }
    }
    
    func gameLost() {
        Task{
            stats?.gameLost()
        }
    }
}

extension GameModel {
    enum GameMode: Codable {
        case normal, hard
    }
}
