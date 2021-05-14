//
//  HistoryView.swift
//  StringsApp
//
//  Created by Lisita Evgheni on 14.05.21.
//

import SwiftUI

struct HistoryView: View {
    @State var history: [String] = UserDefaults(suiteName: "group.com.fox.StringsApp")?.stringArray(forKey: "sharing_history") ?? [String]()
    
    var body: some View {
        VStack {
            Button("Start test") {}
                .padding()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(history, id: \.self) { text in
                        HStack {
                            Text(text)
                                .truncationMode(.tail)
                                .lineLimit(2)
                            Spacer()
                            Text("12 sec")
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
