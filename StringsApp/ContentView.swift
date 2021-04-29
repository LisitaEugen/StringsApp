//
//  ContentView.swift
//  StringsApp
//
//  Created by Evgheni Lisita on 07.02.21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("shared_text", store: UserDefaults(suiteName: "group.com.fox.StringsApp")) var sharedData: String = "My Data"
    
    var body: some View {
        Text(sharedData)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
