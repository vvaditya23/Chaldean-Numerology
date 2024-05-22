//
//  ViewController.swift
//  Chaldean Numerology
//
//  Created by Aditya Vyavahare on 21/05/24.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = ChaldeanNumerologyViewModel()
    
    //UI elements
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

// Setup UI elements
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
        firstNameScoreLabel.text = viewModel.firstNameScore
        lastNameScoreLabel.text = viewModel.lastNameScore
        totalScoreLabel.text = viewModel.totalScore
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

// Calculations
extension ViewController {
    @objc private func calculateButtonTapped() {
        let firstnameInput = firstnameTextField.text ?? ""
        let lastnameInput = lastnameTextField.text ?? ""
        
        viewModel.calculateScores(firstName: firstnameInput, lastName: lastnameInput)
        
        firstNameScoreLabel.text = viewModel.firstNameScore
        lastNameScoreLabel.text = viewModel.lastNameScore
        totalScoreLabel.text = viewModel.totalScore
        image.image = UIImage(named: viewModel.resultImageName)
    }
}
