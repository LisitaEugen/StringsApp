//
//  SufixesViewModel.swift
//  StringsApp
//
//  Created by Lisita Evgheni on 29.04.21.
//

import Foundation
import Combine

enum PrimaryCriteria: Int {
    case all, top10_3chars, top10_5chars
}

enum SecondaryCriteria: Int {
    case asc, desc
}


/*
 2.1.1 листом всех суффиксов, повторяющиеся помечать кол-вом, остортировать по алфавиту, сделать переключение сортировки ASC/DESC
 2.1.2 топом 10 самых популярных 3х буквенных  суффиксов, отсортированных по кол-ву нахождений
 2.1.3 топом 10 самых популярных 5х буквенных  суффиксов, отсортированных по кол-ву нахождений
 */

final class SuffixesViewModel: ObservableObject {
    
    @Published var selectedPrimaryCriteria: PrimaryCriteria = .default {
        didSet {
            applyPrimaryCriteria(oldValue)
        }
    }
    @Published var selectedSecondaryCriteria: SecondaryCriteria = .asc {
        didSet {
            applySecondaryCriteria(oldValue)
        }
    }
    @Published var uniqueSuffixes: [String] = []
    @Published var suffixesWithOccurances: [String: Int] = [:]
    @Published var sortedSuffixes: [String] = []
    
    
    init(text: String?) {
        guard let text = text else {
            return
        }
        
        let words = text.split(whereSeparator: {$0 == " "})
        var suffixes: [String] = []
        
        for word in words {
            let sArray = SuffixArray(word: String(word))
            suffixes.append(contentsOf: sArray)
        }
        
        uniqueSuffixes = suffixes.uniqued().sorted()
        
        for sufix in uniqueSuffixes {
            suffixesWithOccurances[sufix] = suffixes.filter { $0 == sufix }.count
        }
        
        sortedSuffixes = uniqueSuffixes
    }
    
    private func applyPrimaryCriteria(_ sortingCriteria: PrimaryCriteria) {
        print("Criteria changed \(sortingCriteria)")
        switch sortingCriteria {
        case .all:
            sortedSuffixes = uniqueSuffixes
            return
        case .top10_3chars:
            return
        case .top10_5chars:
            return
        }
    }
    
    private func applySecondaryCriteria(_ sortingCriteria: SecondaryCriteria) {
        print("Criteria changed \(sortingCriteria)")
        switch sortingCriteria {
        case .asc:
            sortedSuffixes.sort {
                $0 > $1
            }
            return
        case .desc:
            sortedSuffixes.sort {
                $0 < $1
            }
            return
        }
    }
    
    func top10With3Chars() {
        let threeCharsWords = uniqueSuffixes.filter {$0.count == 3 }
        var threeCharsWordsWithOccurances = suffixesWithOccurances.filter { threeCharsWords.contains($0.key) }
        
//        threeCharsWordsWithOccurances = threeCharsWordsWithOccurances.sorted { $0.value > $1.value }
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
