//
//  String-extensions.swift
//  Squardle
//
//  Created by Сергей Дубовой on 04.10.2022.
//

import Foundation

extension String {
    func getChar(at givenOffset: Int) -> Character? {
        if givenOffset >= self.count {
            return nil
        }
        return self[index(startIndex, offsetBy: givenOffset)]
    }
    
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}
