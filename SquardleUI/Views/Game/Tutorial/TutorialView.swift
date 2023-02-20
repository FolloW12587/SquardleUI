//
//  TutorialView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 19.02.2023.
//

import SwiftUI

struct TutorialView: View {
    @StateObject var tutorialModel = TutorialModel()
    var dismissClosure: () -> ()
    
    var body: some View {
        ZStack {
            ThemeModel.main.backgroundColor.ignoresSafeArea()
            ZStack{
                switch tutorialModel.currentViewTab{
                case .first:
                    FirstView(nextViewClosure: tutorialModel.nextTab)
                case .second:
                    SecondView(nextViewClosure: tutorialModel.nextTab, prevViewClosure: tutorialModel.prevTab)
                case .third:
                    ThirdView(nextViewClosure: tutorialModel.nextTab, prevViewClosure: tutorialModel.prevTab)
                case .fourth:
                    FourthView(nextViewClosure: tutorialModel.nextTab, prevViewClosure: tutorialModel.prevTab)
                case .fifth:
                    FifthView(nextViewClosure: tutorialModel.nextTab, prevViewClosure: tutorialModel.prevTab)
                case .sixth:
                    SixthView(nextViewClosure: tutorialModel.nextTab, prevViewClosure: tutorialModel.prevTab)
                case .seventh:
                    SeventhView(nextViewClosure: tutorialModel.nextTab, prevViewClosure: tutorialModel.prevTab)
                case .eight:
                    EightView(nextViewClosure: dismissClosure, prevViewClosure: tutorialModel.prevTab)
                default:
                    EmptyView()
                }
            }
            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(){}
    }
}
