//
//  ViewController.swift
//  Chaldean Numerology
//
//  Created by Aditya Vyavahare on 15/05/24.
//

import UIKit

class ViewController: UIViewController {
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

    
    //UI elemets
    let firstnameTextField = UITextField()
    let lastnameTextField = UITextField()
    let calculateButton = UIButton()
    let firstNameScoreLabel = UILabel()
    let lastNameScoreLabel = UILabel()
    let totalScoreLabel = UILabel()
    let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupCalculateButton()
        setupScoreLabels()
        setupImage()
    }
}

//Setup UI elements
extension ViewController {
    private func setupTextFields() {
        firstnameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastnameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstnameTextField)
        view.addSubview(lastnameTextField)
        NSLayoutConstraint.activate([
            firstnameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            firstnameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            firstnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            lastnameTextField.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor, constant: 10),
            lastnameTextField.centerXAnchor.constraint(equalTo: firstnameTextField.centerXAnchor),
            lastnameTextField.leadingAnchor.constraint(equalTo: firstnameTextField.leadingAnchor),
            lastnameTextField.trailingAnchor.constraint(equalTo: firstnameTextField.trailingAnchor)
        ])
        firstnameTextField.borderStyle = .roundedRect
        lastnameTextField.borderStyle = .roundedRect
        firstnameTextField.placeholder = "Enter first name"
        lastnameTextField.placeholder = "Enter last name"
    }
    
    private func setupCalculateButton() {
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calculateButton)
        NSLayoutConstraint.activate([
            calculateButton.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor, constant: 25),
            calculateButton.centerXAnchor.constraint(equalTo: firstnameTextField.centerXAnchor),
            calculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            calculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        calculateButton.setTitle("Calculate score", for: .normal)
        calculateButton.setTitleColor(.black, for: .normal)
        calculateButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        calculateButton.layer.borderWidth = 1
        calculateButton.layer.cornerRadius = 10
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
    }
    
    private func setupScoreLabels() {
        firstNameScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        totalScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstNameScoreLabel)
        view.addSubview(lastNameScoreLabel)
        view.addSubview(totalScoreLabel)
        NSLayoutConstraint.activate([
            firstNameScoreLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 50),
            firstNameScoreLabel.centerXAnchor.constraint(equalTo: firstnameTextField.centerXAnchor),
            lastNameScoreLabel.topAnchor.constraint(equalTo: firstNameScoreLabel.bottomAnchor, constant: 10),
            lastNameScoreLabel.centerXAnchor.constraint(equalTo: firstnameTextField.centerXAnchor),
            totalScoreLabel.topAnchor.constraint(equalTo: lastNameScoreLabel.bottomAnchor, constant: 20),
            totalScoreLabel.centerXAnchor.constraint(equalTo: firstnameTextField.centerXAnchor),
        ])
        firstNameScoreLabel.text = "First name score appears here"
        lastNameScoreLabel.text = "Last name score appears here"
        totalScoreLabel.text = "Total score appears here"
    }
    
    private func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 50),
            image.centerXAnchor.constraint(equalTo: firstnameTextField.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

//calculations
extension ViewController {
    @objc private func calculateButtonTapped() {
        let firstnameInput = firstnameTextField.text ?? ""
        let lastnameInput = lastnameTextField.text ?? ""
        
        let firstnameSum = calculateChaldeanNumerology(for: firstnameInput)
        let lastnameSum = calculateChaldeanNumerology(for: lastnameInput)
        
        let firstnameSingleDigit = calculateSingleDigit(from: firstnameSum)
        let lastnameSingleDigit = calculateSingleDigit(from: lastnameSum)
        
        firstNameScoreLabel.text = "First name score: \(firstnameSingleDigit)"
        lastNameScoreLabel.text = "Last name score: \(lastnameSingleDigit)"
        
        let totalSum = firstnameSingleDigit + lastnameSingleDigit
        
        let totalSumSingleDigit = calculateSingleDigit(from: totalSum)
        totalScoreLabel.text = "Total score: \(totalSumSingleDigit)"
        
        switch totalSumSingleDigit {
        case 1, 3, 5, 6:
            image.image = UIImage(named: "accepted")
        default:
            image.image = UIImage(named: "rejected")
        }
    }
    
    // Function to calculate Chaldean numerology count for a given string
    private func calculateChaldeanNumerology(for input: String) -> Int {
        var total = 0
        for character in input.uppercased() {
            if let value = numbersForAlphabets[character] {
                total += value
            }
        }
        return total
    }

    // Function to calculate single-digit addition
    private func calculateSingleDigit(from number: Int) -> Int {
        var sum = number
        while sum > 9 {
            sum = sum.digits.reduce(0, +)
        }
        return sum
    }
}

// Extension to get digits of a number
private extension Int {
    var digits: [Int] {
        return String(self).compactMap { Int(String($0)) }
    }
}
