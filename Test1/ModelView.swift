//
//  ModelView.swift
//  Test1
//
//  Created by Nikita Pavlov on 14.08.2020.
//  Copyright © 2020 Nikita Pavlov. All rights reserved.
//

import Foundation

class ModelView {
    static var isSimpleNumbers = true
    static var maxNumber = 60
    static var displayedNumbers = Model.getSimpleNumbers(2, 60)

    static func changeNumberType() {
        isSimpleNumbers = !isSimpleNumbers
        if isSimpleNumbers {
            maxNumber = 60
            ModelView.displayedNumbers = Model.getSimpleNumbers(2, 60)
        } else {
            maxNumber = 20
            ModelView.displayedNumbers = Model.getFibonacciNumbers(nil, 20)
        }
    }

    static func getMoreNumbers() {
            if isSimpleNumbers {
                let from = maxNumber
                maxNumber += 60
                ModelView.displayedNumbers.append(contentsOf: Model.getSimpleNumbers(from, maxNumber))
            } else {
                maxNumber += 2
                ModelView.displayedNumbers = Model.getFibonacciNumbers(ModelView.displayedNumbers, maxNumber)
            }
    }
}
