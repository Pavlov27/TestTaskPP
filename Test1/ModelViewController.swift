//
//  ModelViewController.swift
//  Test1
//
//  Created by Nikita Pavlov on 08.08.2020.
//  Copyright © 2020 Nikita Pavlov. All rights reserved.
//

import Foundation

class ModelViewController {

    static func getSimpleNumbers(maxNumber: Int) -> [Int] {
    
        let max = maxNumber
        var testValue = 2
        var data = (2...max).map{$0}
        while (testValue*testValue <= max) {
            data.removeAll(where: {$0 >= testValue*testValue && $0.isMultiple(of:       testValue)})
            testValue = data.first(where: {$0 > testValue})!
        }
        return data
    }

    static func fibonacci(n: Int) -> [Int] {

        assert(n > 1)
        var array = [0, 1]
        while array.count < n {
            array.append(array[array.count - 1] + array[array.count - 2])
        }
        return array
    }
}
