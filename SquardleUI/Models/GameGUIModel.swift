//
//  GameGUIModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 28.11.2022.
//

import Foundation

class GameGUIModel: ObservableObject {
    @Published var guessesLeft: Int = 10
    @Published var isSubmitButtonActive: Bool = false
    @Published var areRulesPresented: Bool = false
}
