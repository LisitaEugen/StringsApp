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
            Picker(selection: $viewModel.selectedPrimaryCriteria, label:
                    Text("Primary sorting")
                   , content: {
                    Text("All").tag(PrimaryCriteria.all)
                    Text("Top 3 chars").tag(PrimaryCriteria.top10_3chars)
                    Text("Top 5 chars").tag(PrimaryCriteria.top10_5chars)
                   })
                .pickerStyle(SegmentedPickerStyle())
            if viewModel.selectedPrimaryCriteria == .all {
                Picker(selection: $viewModel.selectedSecondaryCriteria, label:
                        Text("Additional sorting")
                       , content: {
                        Text("Asc").tag(SecondaryCriteria.asc)
                        Text("Desc").tag(SecondaryCriteria.desc)
                       })
                    .pickerStyle(SegmentedPickerStyle())
            }
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.sortedSuffixes, id: \.self) { suffix in
                        HStack {
                            Text(suffix)
                            Spacer()
                            if let occurance = viewModel.suffixesWithOccurances[suffix], occurance > 1 {
                                Text("\(occurance)")
                            }
                            
                        }
                        .padding(10)
                    }
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SuffixesViewModel(text: "a dasdad asd dasd asda asd dasd asd asd asd"))
    }
}
