//
//  StringsAppApp.swift
//  StringsApp
//
//  Created by Evgheni Lisita on 07.02.21.
//

import SwiftUI

@main
struct StringsAppApp: App {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("shared_text", store: UserDefaults(suiteName: "group.com.fox.StringsApp")) var sharedText: String = "" 
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(SuffixesViewModel(text: sharedText))
        }.onChange(of: scenePhase ) { newScenePhase in
            switch (newScenePhase) {
            case .background:
                print("background")
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            @unknown default:
                print("unknown")
            }
        }
    }
}
