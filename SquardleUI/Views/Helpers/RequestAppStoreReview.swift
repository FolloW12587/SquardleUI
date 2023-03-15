//
//  RequestAppStoreReview.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 15.03.2023.
//

import SwiftUI
import StoreKit

enum AppReviewRequest {
    static var threshold = 50
    @AppStorage("runsSinceLastRequest") static var runsSinceLastRequest = 0
    @AppStorage("version") static var version = ""
    @AppStorage("currentStreak") static var currentStreak = 0
    
    static func getThisVersion() -> String {
        let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let thisVersion = "\(appVersion) build: \(appBuild)"
        return thisVersion
    }
    
    static func isRequestNeeded() -> Bool{
        if version == "" && currentStreak >= 3 {
            return true
        }
        runsSinceLastRequest += 1
        
        let thisVersion = getThisVersion()
        if thisVersion != version {
            if runsSinceLastRequest >= threshold {
                return true
            }
        } else {
            runsSinceLastRequest = 0
        }
        return false
    }
    
    static func requestReview() {
        guard let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: scene)
        let thisVersion = getThisVersion()
        version = thisVersion
        runsSinceLastRequest = 0
    }
}
