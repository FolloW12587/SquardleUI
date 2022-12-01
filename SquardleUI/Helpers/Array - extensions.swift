//
//  Array - extensions.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 28.11.2022.
//

import Foundation

extension Array {
    mutating func removeRandom() -> Element? {
        if let index = indices.randomElement() {
            return remove(at: index)
        }
        return nil
    }
}
