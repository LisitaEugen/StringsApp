//
//  SufixesViewModel.swift
//  StringsApp
//
//  Created by Lisita Evgheni on 29.04.21.
//

import Foundation
import Combine

enum SortingCriteria: Int {
    case all, top103chars, top105chars
}

/*
 2.1.1 листом всех суффиксов, повторяющиеся помечать кол-вом, остортировать по алфавиту, сделать переключение сортировки ASC/DESC
 2.1.2 топом 10 самых популярных 3х буквенных  суффиксов, отсортированных по кол-ву нахождений
 2.1.3 топом 10 самых популярных 5х буквенных  суффиксов, отсортированных по кол-ву нахождений
 */

final class SuffixesViewModel: ObservableObject {
    
    @Published var suffixes: [String] = []
    
    init(text: String?) {
        guard let text = text else {
            return
        }
        
        let words = text.split(whereSeparator: {$0 == " "})
        
        for word in words {
            let sArray = SuffixArray(word: String(word))
            sArray.forEach { suffix in
                suffixes.append(suffix)
            }
        }
    }
}
