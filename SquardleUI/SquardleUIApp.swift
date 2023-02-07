//
//  SquardleUIApp.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 22.11.2022.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

@main
struct SquardleUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didFinishLaunching),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        return true
    }
    
    @objc func didFinishLaunching() {
        requestTrackingAuthorization()
    }
    
    func requestTrackingAuthorization(){
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            print(status)
        })
    }
}
