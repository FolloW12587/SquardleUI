//
//  TutorialModel.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import Foundation

class TutorialModel: ObservableObject {
    @Published var currentViewTab: TutorialViewTab? = .first
    
    func nextTab(){
        switch currentViewTab {
        case .first:
            currentViewTab = .second
        case .second:
            currentViewTab = .third
        case .third:
            currentViewTab = .fourth
        case .fourth:
            currentViewTab = .fifth
        case .fifth:
            currentViewTab = .sixth
        case .sixth:
            currentViewTab = .seventh
        case .seventh:
            currentViewTab = .eight
        default:
            currentViewTab = nil
        }
    }
    
    func prevTab() {
        switch currentViewTab {
        case .second:
            currentViewTab = .first
        case .third:
            currentViewTab = .second
        case .fourth:
            currentViewTab = .third
        case .fifth:
            currentViewTab = .fourth
        case .sixth:
            currentViewTab = .fifth
        case .seventh:
            currentViewTab = .sixth
        case .eight:
            currentViewTab = .seventh
        default:
            return
        }
    }
}

extension TutorialModel {
    enum TutorialViewTab {
        case first, second, third, fourth, fifth, sixth, seventh, eight
    }
}
