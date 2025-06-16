//
//  PersonalInfoViewController.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import UIKit

final class PersonalInfoViewController: UIViewController {
    private lazy var textfieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.configure(
            placeholder: "Full Name",
            cornerRadius: 8,
            borderWidth: 1,
            borderColor: .black,
        )
        return textField
    }()
    
    private lazy var numberTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.configure(
            placeholder: "Phone Number",
            cornerRadius: 8,
            borderWidth: 1,
            borderColor: .black
        )
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.configure(
            withColor: .systemCyan,
            title: "Confirm",
            isEnabled: false
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelfView()
        setupViews()
        setupActions()
        handleTextFieldObservation()
    }
    
    private func setupSelfView() {
        view.backgroundColor = .white
    }
    
    private func setupViews() {
        addSubviews()
        addArrangedSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(textfieldStackView)
    }
    
    private func addArrangedSubviews() {
        textfieldStackView.addArrangedSubview(nameTextField)
        textfieldStackView.addArrangedSubview(numberTextField)
        textfieldStackView.addArrangedSubview(confirmButton)
    }
    
    private func setupConstraints() {
        setupStackViewConstraints()
        setupTextFieldsConstraints()
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate(
            [
                textfieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                textfieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                textfieldStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            ]
        )
    }
    
    private func setupTextFieldsConstraints() {
        NSLayoutConstraint.activate(
            [
                nameTextField.heightAnchor.constraint(equalToConstant: 56),
                numberTextField.heightAnchor.constraint(equalToConstant: 56)
            ]
        )
    }
    
    private func setupActions() {
        
    }
    
    private func handleButtonTap() {
        
    }
    
    private func handleTextFieldObservation() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
           numberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        validateInputs()
    }
    
    private func validateInputs() {
        let nameIsValid = !(nameTextField.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty
        let number = numberTextField.text ?? ""
        let numberIsValid = number.trimmingCharacters(in: .whitespaces).count >= 9 // or use regex

        if nameIsValid && numberIsValid {
            confirmButton.isEnabled = true
            confirmButton.alpha = 1.0
        } else {
            confirmButton.isEnabled = false
            confirmButton.alpha = 0.5
        }
    }
}
