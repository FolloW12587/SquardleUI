//
//  PlaySound.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 15.12.2022.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer!

func playSound(_ filename: String, withExtension: String = "wav") {
    Task{
        guard let url = Bundle.main.url(forResource: filename, withExtension: withExtension) else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
