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
            switchPreferedTheme()
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
        switchPreferedTheme()
    }
    
    func save() {
        let defaults = UserDefaults.standard
        
        defaults.set(theme.rawValue, forKey: "theme")
        defaults.set(isSoundOff, forKey: "isSoundOff")
        defaults.set(isVibrationsOff, forKey: "isVibrationsOff")
    }
    
    func switchPreferedTheme() {
        switch theme {
        case .auto:
            preferedColorScheme = nil
        case .light:
            preferedColorScheme = .light
        case .dark:
            preferedColorScheme = .dark
        }
    }
}

extension GameSettings {
    enum ThemeScheme: String {
        case light, dark, auto
    }
}
