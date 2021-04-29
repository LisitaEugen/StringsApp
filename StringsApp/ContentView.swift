//
//  ContentView.swift
//  StringsApp
//
//  Created by Evgheni Lisita on 07.02.21.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 0 {
        didSet {
        }
    }
    @EnvironmentObject var viewModel: SuffixesViewModel
    
    var body: some View {
        VStack {
            Picker(selection: $selection, label:
                    Text("Picker Name")
                   , content: {
                    Text("Value 1").tag(0)
                    Text("Value 2").tag(1)
                    Text("Value 3").tag(2)
                   })
                .pickerStyle(SegmentedPickerStyle())
            Text(String(selection))
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
