//
//  GameGUIModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 28.11.2022.
//

import Foundation

class GameGUIModel: ObservableObject {
    @Published var guessesLeft: Int {
        didSet {
            guessesAdded = guessesLeft - oldValue
        }
    }
    @Published var guessesAdded: Int = 0 {
        didSet {
            animateGuessesAdded = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.animateGuessesAdded = false
            }
        }
    }
    @Published var animateGuessesAdded: Bool = false
    @Published var isSubmitButtonActive: Bool = false
    @Published var areRulesPresented: Bool = false
    @Published var areStatsPresented: Bool = false
    
    init(guessesLeft: Int, isSubmitButtonActive: Bool = false, areRulesPresented: Bool = false, areStatsPresented: Bool = false) {
        self.guessesLeft = guessesLeft
        self.isSubmitButtonActive = isSubmitButtonActive
        self.areRulesPresented = areRulesPresented
        self.areStatsPresented = areStatsPresented
    }
}
