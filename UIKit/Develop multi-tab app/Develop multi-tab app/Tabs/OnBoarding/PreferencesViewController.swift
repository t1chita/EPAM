//
//  PreferencesViewController.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//


import UIKit

final class PreferencesViewController: UIViewController {
    private var selectedPreference: String? {
        didSet {
            preferenceLabel.text = "Selected: \(selectedPreference ?? "None")"
        }
    }
    
    private lazy var selectButton: BaseButton = {
        let button = BaseButton()
        button.configure(
            withColor: .systemCyan,
            title: "Select Notification Preference",
        )
        return button
    }()
    
    private lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.configure(
            withColor: .systemGreen,
            title: "Confirm",
        )
        return button
    }()
    
    private lazy var preferenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Selected: None"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelfView()
        setupViews()
        setupActions()
    }
    
    private func setupSelfView() {
        view.backgroundColor = .white
    }
    
    private func setupViews() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(selectButton)
        view.addSubview(preferenceLabel)
        view.addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        setupSelectButtonConstraints()
        setupPreferenceLabelConstraints()
        setupConfirmationButtonConstraints()
    }
    
    private func setupSelectButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                selectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        )
    }
    
    private func setupPreferenceLabelConstraints() {
        NSLayoutConstraint.activate(
            [
                preferenceLabel.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 16),
                preferenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        )
    }
    
    private func setupConfirmationButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                confirmButton.topAnchor.constraint(equalTo: preferenceLabel.bottomAnchor, constant: 16),
                confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        )
    }
    
    private func setupActions() {
        selectButton.addAction(UIAction(handler: { [weak self] _ in
            self?.showPreferenceActionSheet()
        }), for: .touchUpInside)
        
        confirmButton.addAction(UIAction(handler: { [weak self] _ in
            UserManager.shared.preference = self?.selectedPreference ?? "None"
            
            self?.handleChoosingPreference()
        }), for: .touchUpInside)
    }
    
    private func handleChoosingPreference() {
        let vc = ConfirmDetailsViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showPreferenceActionSheet() {
        let actionSheet = UIAlertController(
            title: "Select Notification Preference",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let emailAction = UIAlertAction(
            title: "Email Notifications",
            style: .default
        ) { [weak self] _ in
            self?.selectedPreference = "Email"
        }
        
        let smsAction = UIAlertAction(
            title: "SMS Notifications",
            style: .default
        ) { [weak self] _ in
            self?.selectedPreference = "SMS"
        }
        
        let pushAction = UIAlertAction(
            title: "Push Notifications",
            style: .default
        ) { [weak self] _ in
            self?.selectedPreference = "Push"
        }
        
        let cancel = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        
        [emailAction, smsAction, pushAction, cancel].forEach { actionSheet.addAction($0) }
        
        present(actionSheet, animated: true)
    }
}
