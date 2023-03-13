//
//  GameEndView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 02.12.2022.
//

import SwiftUI

struct GameEndView: View {
    @EnvironmentObject var theme: ThemeModel
    let homeAction: () -> ()
    let statsAction: () -> ()
    let restartAction: () -> ()
    let showSolutionAction: () -> ()
    
    @State var showShowSolutionButton = true
    
    var body: some View {
        ZStack {
            if showShowSolutionButton{
                Color.init(white: 0, opacity: 0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            ZStack {
                theme.backgroundColor
                
                VStack {
                    Text("Игра окончена")
                        .font(.title.bold())
                    
                    Text("У вас закончились ходы!")
                        .padding()
                        
                    if showShowSolutionButton{
                        Button{
                            showSolutionAction()
                            withAnimation {
                                showShowSolutionButton = false
                            }
                        } label: {
                            Text("Решение")
                        }
                        .buttonStyle(MenuButtonStyle())
                        .padding(.bottom)
                    }
                    
                    actionButtons
                }
            }
            .cornerRadius(20)
            .scaledToFit()
            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
            .padding(.horizontal, 20)
            .clipped()
            .shadow(radius: 4)
        }
        .ignoresSafeArea()
    }
    
    var actionButtons: some View {
        HStack {
            Spacer()
            Button (action: homeAction){
                Image(systemName: "house.circle")
            }
            Spacer()
            Button(action: statsAction) {
                Image(systemName: "list.star")
            }
            Spacer()
            
            Button(action: restartAction) {
                Image(systemName: "arrow.counterclockwise.circle")
            }
            Spacer()
        }
        .foregroundColor(Color.primary)
        .font(.system(size: 50))
    }
}

struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndView() {
        } statsAction: {
        } restartAction: {
        } showSolutionAction: {
        }
        .environmentObject(ThemeModel())
    }
}
