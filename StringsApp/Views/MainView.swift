//
//  Main.swift
//  StringsApp
//
//  Created by Lisita Evgheni on 14.05.21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            TabView {
                ContentView()
                    .tabItem({ Text("Main").font(.title) })
                    .tag(0)
                HistoryView()
                    .tabItem({ Text("History").font(.title) })
                    .tag(1)
            }
//            .tabViewStyle(PageTabViewStyle())
            Spacer()
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
