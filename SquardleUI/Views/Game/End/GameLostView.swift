//
//  GameLostView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 13.04.2023.
//

import SwiftUI

struct GameLostView: View {
    var boardModel: BoardEndModel
    let homeAction: () -> ()
    let newGameAction: () -> ()
    let statsAction: () -> ()
    @EnvironmentObject var theme: ThemeModel
    
    @State var showSolution = false
    
    var body: some View {
        ZStack {
            theme.backgroundColor
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                BoardEndView(boardModel: boardModel)
                Spacer()
                KeyboardView(keyboardModel: KeyboardModel(), tapAction: {_ in })
                    .disabled(true)
            }
            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
            
            VStack {
                if showSolution {
                    Spacer()
                }
            
                GameEndView() {
                    homeAction()
                } statsAction: {
                    statsAction()
                } restartAction: {
                    newGameAction()
                } showSolutionAction: {
                    showSolution = true
                    boardModel.showSolution()
                }
                .animation(.easeInOut(duration: 0.5), value: showSolution)
            }
        }
    }
}

struct GameLostView_Previews: PreviewProvider {
    static var previews: some View {
        GameLostView(boardModel: BoardEndModel(tiles: []), homeAction: {}, newGameAction: {}, statsAction: {})
            .environmentObject(ThemeModel())
    }
}
