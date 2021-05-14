//
//  HistoryViewModel.swift
//  StringsApp
//
//  Created by Lisita Evgheni on 14.05.21.
//

import Foundation


final class HistoryViewModel: ObservableObject {
    
    @Published var history: [String]
    @Published var executionTime: [Int: Double] = [:]
    
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    init(_ history: [String]) {
        self.history = history
    }
    
    
    func startTest() {
        queue.cancelAllOperations()
        
        for (index, text) in history.enumerated() {
            let operation = BlockOperation()
            
            operation.addExecutionBlock() { [weak operation] in
                guard let operation = operation, !operation.isCancelled else {
                    return
                }
                
                let executionTimeSec = self.timeElapsedInSecondsWhenRunningCode {
                    
                    var uniqueSuffixes: [String] = []
                    var suffixesWithOccurances: [String: Int] = [:]
                    
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
                }
                
                print(text)
                print("\(executionTimeSec) sec")
                
                DispatchQueue.main.async() {
                    guard !operation.isCancelled else { return }
                    
                    self.executionTime[index] = executionTimeSec
                }
            }
            
            queue.addOperation(operation)
        }
    }
    
    func timeElapsedInSecondsWhenRunningCode(operation: ()->()) -> Double {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        return Double(timeElapsed)
    }
    
}
