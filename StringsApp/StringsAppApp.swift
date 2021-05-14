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
//    @AppStorage<[String]>("sharing_history", store: UserDefaults(suiteName: "group.com.fox.StringsApp")) var history: [String] = []
    @State var history: [String] = UserDefaults(suiteName: "group.com.fox.StringsApp")?.stringArray(forKey: "sharing_history") ?? [String]()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(SuffixesViewModel(text: sharedText))
                .environmentObject(HistoryViewModel(history))
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
