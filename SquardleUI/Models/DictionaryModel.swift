//
//  Dictionary.swift
//  Squardle
//
//  Created by Сергей Дубовой on 27.09.2022.
//

import Foundation


class DictionaryModel {
    private var words: [(word: String, PoS: String, freq: Float)] = []
    
    init(){
        self.words = self.readWords()
    }
    
    private func readWords() -> [(word: String, PoS: String, freq: Float)]{
        let file = "freqrnc2011_filtered_sorted"
        
        guard let fileURL = Bundle.main.url(forResource: file, withExtension: "csv") else {
            fatalError("Can't find the words dictionary file!")
        }
        
        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
                .split(separator: "\n")
                .map{
                    let seq = String($0).split(separator: "\t")
                    return try (word: String(seq[0]), PoS: String(seq[1]), freq: Float(String(seq[2]), format: .number))
                }
        }
        catch {
            fatalError("Can't read the words dictionary!")
        }
    }
    
    func generateWords(mode gameMode: GameModel.GameMode = .normal) -> [String]{
        let words: [String]
        switch gameMode{
        case .normal:
            words = self.words.filter{ $0.freq > 0.6 && $0.PoS == "s" }.map{ $0.word }
        case .hard:
            words = self.words.filter{ $0.PoS == "s" }.map{ $0.word }
        }
        var i = 0
        
        while true {
            i += 1
            let firstWord = words.randomElement()!
            var ignoreList = [firstWord]
            
            guard let fourthWord = getWordByMask(firstWord.getChar(at: 0), nil, nil, from: words, ignore: ignoreList) else {
                continue
            }
            ignoreList.append(fourthWord)
            
            guard let fifthWord = getWordByMask(firstWord.getChar(at: 2), nil, nil, from: words, ignore: ignoreList) else {
                continue
            }
            ignoreList.append(fifthWord)
            
            guard let sixthWord = getWordByMask(firstWord.getChar(at: 4), nil, nil, from: words, ignore: ignoreList) else {
                continue
            }
            ignoreList.append(sixthWord)
            
            guard let secondWord = getWordByMask(fourthWord.getChar(at: 2), fifthWord.getChar(at: 2), sixthWord.getChar(at: 2), from: words, ignore: ignoreList) else {
                continue
            }
            ignoreList.append(secondWord)
            
            guard let thirdWord = getWordByMask(fourthWord.getChar(at: 4), fifthWord.getChar(at: 4), sixthWord.getChar(at: 4), from: words, ignore: ignoreList) else {
                continue
            }
            
            let selectedWords = [firstWord, secondWord, thirdWord, fourthWord, fifthWord, sixthWord]
            print("In \(i) iterations generated: \(selectedWords)")
            return selectedWords
        }
    }
    
    private func getWordByMask(_ firstLetter: Character?, _ thirdLetter: Character?, _ fifthLetter: Character?, from words: [String], ignore ignoreList: [String] = []) -> String? {
        let filteredWords = words.filter{
            (firstLetter == nil || $0.getChar(at: 0) == firstLetter) && (thirdLetter == nil || $0.getChar(at: 2) == thirdLetter) && (fifthLetter == nil || $0.getChar(at: 4) == fifthLetter) && !ignoreList.contains($0)
        }

        return filteredWords.randomElement()
    }
    
    func wordExists(word: String) -> Bool {
        return self.words.filter{ $0.word == word }.count > 0
    }
}
