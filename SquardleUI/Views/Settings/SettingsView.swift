//
//  SettingsView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 26.03.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: GameSettings
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var theme: ThemeModel
    var dismissAction: () -> ()
    
    var selected_theme: String {
        switch settings.theme {
        case .auto:
            return "Системная"
        case .dark:
            return "Темная"
        case .light:
            return "Светлая"
        }
    }
    
    var stopsAtTheme: Double {
        switch settings.theme {
        case .auto:
            return 0.5
        case .dark:
            return 1
        case .light:
            return 0
        }
    }
    
    var stopsAtSound: Double {
        return settings.isSoundOff ? 0 : 1
    }
    
    var stopsAtVibration: Double {
        return settings.isVibrationsOff ? 0 : 1
    }
    
    var body: some View {
        ZStack {
            theme.backgroundColor
                .ignoresSafeArea()
            
            VStack{
                DismissButtonView(dismissAction: dismissAction)
                    .padding()
                    .foregroundColor(.primary)
                
                Text("Настройки")
                    .font(.title.bold())
                Spacer()
            }
            
            VStack (spacing: 40){
                HStack{
                    AsymetricRectangleView(stopsAt: stopsAtTheme, leftColor: .black, rightColor: .white)
                        .frame(width: 30, height: 30)
                    Text("Тема")
                    Spacer()
                    Text(selected_theme)
                        .frame(width: 145)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(theme.tileMainBackgroundColor))
                        .animation(.none, value: settings.theme)
                        .onTapGesture(perform: switchTheme)
                }
                .font(.system(.title2))
                .padding(.horizontal, 40)
                
                
                HStack{
                    AsymetricRectangleView(stopsAt: stopsAtSound)
                        .frame(width: 30, height: 30)
                    Toggle(isOn: Binding<Bool>(get: {return !self.settings.isSoundOff},
                                               set: { p in self.settings.isSoundOff = !p})
                    ) {
                        Text("Звук")
                    }
                    .tint(.green)
                }
                .font(.system(.title2))
                .padding(.horizontal, 40)
                
                HStack{
                    AsymetricRectangleView(stopsAt: stopsAtVibration)
                        .frame(width: 30, height: 30)
                    Toggle(isOn: Binding<Bool>(get: {return !self.settings.isVibrationsOff},
                                               set: { p in self.settings.isVibrationsOff = !p})
                    ) {
                        Text("Вибрация")
                    }
                    .tint(.green)
                }
                .font(.system(.title2))
                .padding(.horizontal, 40)
            }
        }
    }
    
    func switchTheme() {
        withAnimation {
            switch settings.theme {
            case .auto:
                settings.theme = .dark
            case .dark:
                settings.theme = .light
            case .light:
                settings.theme = .auto
            }
        }
        TactileResponse.shared.makeResponse(feedbackStyle: .medium, systemSoundID: SoundMatcher.keyPressed.rawValue)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(){}
            .environmentObject(GameSettings())
            .environmentObject(ThemeModel())
    }
}
