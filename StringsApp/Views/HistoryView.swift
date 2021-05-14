//
//  HistoryView.swift
//  StringsApp
//
//  Created by Lisita Evgheni on 14.05.21.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var viewModel: HistoryViewModel
            
    var body: some View {
        VStack {
            Button("Start test") {
                viewModel.startTest()
            }
            .padding()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(0..<viewModel.history.count) { index in
                        HStack {
                            Text("\(viewModel.history[index])")
                                .truncationMode(.tail)
                                .lineLimit(2)
                            Spacer()
                            if viewModel.executionTime[index] != nil {
                                Text("\(viewModel.executionTime[index] ?? 0.0) sec")
                            }
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
