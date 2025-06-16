//
//  ConfirmDetailsViewController.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import UIKit

final class ConfirmDetailsViewController: UIViewController {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var preferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Buttons
    private lazy var startOverButton: BaseButton = {
        let button = BaseButton()
        button.configure(withColor: .systemRed, title: "Start Over")
        return button
    }()
    
    private lazy var editPreferencesButton: BaseButton = {
        let button = BaseButton()
        button.configure(withColor: .systemOrange, title: "Edit Preferences")
        return button
    }()
    
    private lazy var editPersonalInfoButton: BaseButton = {
        let button = BaseButton()
        button.configure(withColor: .systemBlue, title: "Edit Personal Info")
        return button
    }()
    
    private lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.configure(withColor: .systemGreen, title: "Confirm")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelfView()
        setupViews()
        setupActions()
        populateUserData()
    }
    
    private func setupSelfView() {
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setupViews() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(preferenceLabel)
        view.addSubview(startOverButton)
        view.addSubview(editPreferencesButton)
        view.addSubview(editPersonalInfoButton)
        view.addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        setupNameLabelConstraints()
        setupPhoneLabelConstraints()
        setupPreferenceLabelConstraints()
        setupStartOverButtonConstraints()
        setupEditPreferencesButtonConstraints()
        setupEditPersonalInfoButtonConstraints()
        setupConfirmButtonConstraints()
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate(
            [
                nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ]
        )
    }
    
    private func setupPhoneLabelConstraints() {
        NSLayoutConstraint.activate(
            [
                phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
                phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ]
        )
    }
    
    private func setupPreferenceLabelConstraints() {
        NSLayoutConstraint.activate(
            [
                preferenceLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 16),
                preferenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ]
        )
    }
    
    private func setupStartOverButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                startOverButton.topAnchor.constraint(equalTo: preferenceLabel.bottomAnchor, constant: 40),
                startOverButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                startOverButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ]
        )
    }
    
    private func setupEditPreferencesButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                editPreferencesButton.topAnchor.constraint(equalTo: startOverButton.bottomAnchor, constant: 16),
                editPreferencesButton.leadingAnchor.constraint(equalTo: startOverButton.leadingAnchor),
                editPreferencesButton.trailingAnchor.constraint(equalTo: startOverButton.trailingAnchor),
            ]
        )
    }
    
    private func setupEditPersonalInfoButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                editPersonalInfoButton.topAnchor.constraint(equalTo: editPreferencesButton.bottomAnchor, constant: 16),
                editPersonalInfoButton.leadingAnchor.constraint(equalTo: startOverButton.leadingAnchor),
                editPersonalInfoButton.trailingAnchor.constraint(equalTo: startOverButton.trailingAnchor),
            ]
        )
    }
    
    private func setupConfirmButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                confirmButton.topAnchor.constraint(equalTo: editPersonalInfoButton.bottomAnchor, constant: 16),
                confirmButton.leadingAnchor.constraint(equalTo: startOverButton.leadingAnchor),
                confirmButton.trailingAnchor.constraint(equalTo: startOverButton.trailingAnchor)
            ]
        )
    }
    
    private func setupActions() {
          startOverButton.addAction(UIAction(handler: { [weak self] _ in
              UserManager.shared.reset()
              self?.navigationController?.popToRootViewController(animated: true)
          }), for: .touchUpInside)
          
          editPreferencesButton.addAction(UIAction(handler: { [weak self] _ in
              if let vc = self?.navigationController?.viewControllers.first(where: { $0 is PreferencesViewController }) {
                  self?.navigationController?.popToViewController(vc, animated: true)
              }
          }), for: .touchUpInside)
          
          editPersonalInfoButton.addAction(UIAction(handler: { [weak self] _ in
              if let vc = self?.navigationController?.viewControllers.first(where: { $0 is PersonalInfoViewController }) {
                  self?.navigationController?.popToViewController(vc, animated: true)
              }
          }), for: .touchUpInside)
          
          confirmButton.addAction(UIAction(handler: { [weak self] _ in
              self?.showConfirmationAlert()
          }), for: .touchUpInside)
      }
      
      private func showConfirmationAlert() {
          let alert = UIAlertController(
              title: "Success",
              message: "You have successfully passed onboarding.",
              preferredStyle: .alert
          )
          
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
              // Restart app flow
              UserManager.shared.hasOnboarded = true // Optional: update flag
              if let onboardingVC = self?.navigationController?.viewControllers.first(where: { $0 is OnBoardingViewController }) as? OnBoardingViewController {
                  onboardingVC.updateForRestartedState()
                  self?.navigationController?.popToViewController(onboardingVC, animated: true)
              } else {
                  self?.navigationController?.popToRootViewController(animated: true)
              }
          }))
          present(alert, animated: true)
      }
      
    
    private func populateUserData() {
        let name = UserManager.shared.name
        let phone = UserManager.shared.number
        let preference = UserManager.shared.preference
        
        nameLabel.text = "Name: \(name)"
        phoneLabel.text = "Phone Number: \(phone)"
        preferenceLabel.text = "Notification Preference: \(preference) Notifications"
    }
}
