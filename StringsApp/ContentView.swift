//
//  ContentView.swift
//  StringsApp
//
//  Created by Evgheni Lisita on 07.02.21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: SuffixesViewModel
    
    var body: some View {
        VStack {
            Picker(selection: $viewModel.selectedCriteria, label:
                    Text("Picker Name")
                   , content: {
                    Text("Value 1").tag(SortingCriteria.default)
                    Text("Value 2").tag(SortingCriteria.top10_3chars)
                    Text("Value 3").tag(SortingCriteria.top10_5chars)
                   })
                .pickerStyle(SegmentedPickerStyle())
            ScrollView {
                ForEach(viewModel.suffixes, id: \.self) { suffix in
                    Text(suffix)
                        .frame(width: 300, height: 20, alignment: .leading)
                }
            }
            .frame(width: .infinity)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SuffixesViewModel(text: "a dasdad asd dasd asda asd dasd asd asd asd"))
    }
}
