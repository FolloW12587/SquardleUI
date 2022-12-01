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
    
    func generateWords() -> [String]{
        let words = self.words.filter{ $0.freq > 0.6 && $0.PoS == "s" }.map{ $0.word }
        
        let firstWord = words.randomElement()!
        var secondWord = words.randomElement()!
        var thirdWord = words.randomElement()!
        
        while true {
            if secondWord != firstWord {
                break
            }
            secondWord = words.randomElement()!
        }
        
        while true {
            if thirdWord != firstWord && thirdWord != secondWord {
                break
            }
            thirdWord = words.randomElement()!
        }
        
        var selectedWords = [firstWord, secondWord, thirdWord]
        for i in stride(from: 0, to: 5, by: 2){
            let firstLetter = firstWord.getChar(at: i)!
            let thirdLetter = secondWord.getChar(at: i)!
            let fifthLetter = thirdWord.getChar(at: i)!

            let filteredWords = words.filter{
                $0.getChar(at: 0) == firstLetter && $0.getChar(at: 2) == thirdLetter && $0.getChar(at: 4) == fifthLetter && !selectedWords.contains($0)
            }
            
            if filteredWords.count == 0 {
//                print("Can't find word with mask \(firstLetter)?\(thirdLetter)?\(fifthLetter). Recreating!")
                return generateWords()
            }
            let word = filteredWords.randomElement()!
            selectedWords.append(word)
        }
        print(selectedWords)
        return selectedWords
    }
    
    func wordExists(word: String) -> Bool {
        return self.words.filter{ $0.word == word }.count > 0
    }
}
