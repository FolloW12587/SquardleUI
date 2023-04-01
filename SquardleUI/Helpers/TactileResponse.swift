//
//  TactileResponse.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 01.04.2023.
//

import SwiftUI
import AVFoundation

class TactileResponse {
    static let shared = TactileResponse()
    
    func isSoundOn() -> Bool {
        @AppStorage("isSoundOff") var isSoundOff = false
        
        return !isSoundOff
    }
    
    func isVibrationsOn() -> Bool {
        @AppStorage("isVibrationsOff") var isVibrationsOff = false
        
        return !isVibrationsOff
    }
    
    func makeResponse(feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle, soundFilename: String, withExtension soundFileExtension: String = "wav"){
        if isVibrationsOn() {
            makeVibration(feedbackStyle)
        }
        
        if isSoundOn() {
            playSound(soundFilename, withExtension: soundFileExtension)
        }
    }
    
    func makeResponse(feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle, systemSoundID: SystemSoundID){
        if isVibrationsOn() {
            makeVibration(feedbackStyle)
        }
        
        if isSoundOn() {
            playSound(systemSoundID)
        }
    }
}
