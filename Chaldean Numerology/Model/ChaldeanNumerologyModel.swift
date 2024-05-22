//
//  ChaldeanNumerologyModel.swift
//  Chaldean Numerology
//
//  Created by Aditya Vyavahare on 21/05/24.
//

import Foundation

struct ChaldeanNumerologyModel {
    let numbersForAlphabets: [Character: Int] = [
        "A": 1,
        "B": 2,
        "C": 3,
        "D": 4,
        "E": 5,
        "F": 8,
        "G": 3,
        "H": 5,
        "I": 1,
        "J": 1,
        "K": 2,
        "L": 3,
        "M": 4,
        "N": 5,
        "O": 7,
        "P": 8,
        "Q": 1,
        "R": 2,
        "S": 3,
        "T": 4,
        "U": 6,
        "V": 6,
        "W": 6,
        "X": 6,
        "Y": 1,
        "Z": 7
    ]
    
    func calculateChaldeanNumerology(for input: String) -> Int {
        var total = 0
        for character in input.uppercased() {
            if let value = numbersForAlphabets[character] {
                total += value
            }
        }
        return total
    }
    
    func calculateSingleDigit(from number: Int) -> Int {
        var sum = number
        while sum > 9 {
            sum = sum.digits.reduce(0, +)
        }
        return sum
    }
}

private extension Int {
    var digits: [Int] {
        return String(self).compactMap { Int(String($0)) }
    }
}
