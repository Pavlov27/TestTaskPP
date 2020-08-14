//
//  ModelViewController.swift
//  Test1
//
//  Created by Nikita Pavlov on 08.08.2020.
//  Copyright © 2020 Nikita Pavlov. All rights reserved.
//

import Foundation

class Model {

    static func getSimpleNumbers(_ from: Int, _ to: Int) -> [Int] {

        var data = [Int]()

        for i in from...to {
            if i > 1 && !(2..<i).contains(where: { i % $0 == 0 }) {
                data.append(i)
            }
        }
        return data
    }

    static func getFibonacciNumbers(_ from: [Int]?, _ to: Int) -> [Int] {

        var data = from ?? [0,1]
        while data.count < to {
            data.append(data[data.count - 1] + data[data.count - 2])
        }
        return data
    }

        static func getSimpleNumbersOld(maxNumber: Int) -> [Int] {
    
            let max = maxNumber
            var testValue = 2
            var data = (2...max).map{$0}
            while (testValue*testValue <= max) {
                data.removeAll(where: {$0 >= testValue*testValue && $0.isMultiple(of:       testValue)})
                testValue = data.first(where: {$0 > testValue})!
            }
            return data
        }
}
