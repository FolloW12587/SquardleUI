//
//  Settings.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 26.03.2023.
//

import Foundation
import SwiftUI

class GameSettings: ObservableObject {
    var theme: ThemeScheme = .auto {
        didSet {
            switch theme {
            case .auto:
                preferedColorScheme = nil
            case .light:
                preferedColorScheme = .light
            case .dark:
                preferedColorScheme = .dark
            }
            save()
        }
    }
    @Published var isSoundOff: Bool = false {
        didSet {
            save()
        }
    }
    @Published var isVibrationsOff: Bool = false {
        didSet {
            save()
        }
    }
    @Published var preferedColorScheme: ColorScheme? = nil
    
    init() {
        let defaults = UserDefaults.standard
        
        theme = ThemeScheme(rawValue: defaults.string(forKey: "theme") ?? "auto") ?? .auto
        isSoundOff = defaults.bool(forKey: "isSoundOff")
        isVibrationsOff = defaults.bool(forKey: "isVibrationsOff")
    }
    
    func save() {
        let defaults = UserDefaults.standard
        
        defaults.set(theme.rawValue, forKey: "theme")
        defaults.set(isSoundOff, forKey: "isSoundOff")
        defaults.set(isVibrationsOff, forKey: "isVibrationsOff")
    }
}

extension GameSettings {
    enum ThemeScheme: String {
        case light, dark, auto
    }
}
