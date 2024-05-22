//
//  ChaldeanNumerologyViewModel.swift
//  Chaldean Numerology
//
//  Created by Aditya Vyavahare on 21/05/24.
//

import Foundation

class ChaldeanNumerologyViewModel {
    private let model = ChaldeanNumerologyModel()
    
    var firstNameScore: String = "First name score appears here"
    var lastNameScore: String = "Last name score appears here"
    var totalScore: String = "Total score appears here"
    var resultImageName: String = "default"
    
    func calculateScores(firstName: String, lastName: String) {
        let firstnameSum = model.calculateChaldeanNumerology(for: firstName)
        let lastnameSum = model.calculateChaldeanNumerology(for: lastName)
        
        let firstnameSingleDigit = model.calculateSingleDigit(from: firstnameSum)
        let lastnameSingleDigit = model.calculateSingleDigit(from: lastnameSum)
        
        firstNameScore = "First name score: \(firstnameSingleDigit)"
        lastNameScore = "Last name score: \(lastnameSingleDigit)"
        
        let totalSum = firstnameSingleDigit + lastnameSingleDigit
        let totalSumSingleDigit = model.calculateSingleDigit(from: totalSum)
        totalScore = "Total score: \(totalSumSingleDigit)"
        
        switch totalSumSingleDigit {
        case 1, 3, 5, 6:
            resultImageName = "accepted"
        default:
            resultImageName = "rejected"
        }
    }
}
