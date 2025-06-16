//
//  SettingsViewController.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import UIKit

final class SettingsViewController: UIViewController {
    private lazy var toggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Navigation is easy!"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        return toggle
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [toggleLabel, toggleSwitch])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelfView()
        setupViews()
    }
    
    private func setupSelfView() {
        view.backgroundColor = .red
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
