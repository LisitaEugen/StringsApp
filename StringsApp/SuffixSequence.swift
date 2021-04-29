//
//  SuffixSequence.swift
//  StringsApp
//
//  Created by Lisita Evgheni on 03.04.21.
//

import Foundation

struct SuffixSequence: Sequence, IteratorProtocol {
    var currentIndex = 0
    var suffixArray: [String]
    
    init(word: String) {
        func calculateSuffixArray(for word: String) -> [String] {
            var suffixDict = [Int: String]()

            for index in 0...word.count-1 {
                let indexStart = word.index(word.startIndex, offsetBy: index)
                suffixDict[index] = String(word[indexStart...])
            }

            return suffixDict.values.sorted()
        }
        
        suffixArray = calculateSuffixArray(for: word)
    }

    mutating func next() -> String? {
        defer {
            currentIndex += 1
        }

        return currentIndex < suffixArray.count ?  suffixArray[currentIndex] : nil
    }
}
