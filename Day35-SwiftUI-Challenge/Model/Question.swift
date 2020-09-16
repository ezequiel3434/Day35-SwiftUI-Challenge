//
//  Question.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 14/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

struct Question: Hashable {
    let firstNumber:Int
    let secondNumber: Int
    var tableNumber: Int = 0
    
    var goodAnswer: Int {
        return firstNumber * secondNumber
    }
    var position: Int
    var wellAnswerd = false
}
