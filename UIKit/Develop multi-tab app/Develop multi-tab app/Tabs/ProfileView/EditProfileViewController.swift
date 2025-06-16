//
//  EditProfileViewController.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import UIKit

final class EditProfileViewController: UIViewController {
    private lazy var colorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Color: Purple"
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var changeColorButton: BaseButton = {
        let button = BaseButton()
        button.configure(
            withColor: .black,
            title: "Change Color"
        )
        return button
    }()
    
    private let colors: [(name: String, color: UIColor)] = [
        ("Red", .red),
        ("Green", .green),
        ("Blue", .blue),
        ("Orange", .orange),
        ("Yellow", .yellow),
        ("Cyan", .cyan),
        ("Magenta", .magenta),
        ("Gray", .gray),
        ("Purple", .purple),
        ("Brown", .brown)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
        setupSelfView()
        setupViews()
        setupActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View Did Appear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View Will Appear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("View Will Layout Subviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("View Did Layout Subviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View Will Disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View Did Disappear")
    }
    
    private func setupSelfView() {
        view.backgroundColor = .purple
    }
    
    private func setupViews() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(colorNameLabel)
        view.addSubview(changeColorButton)
    }
    
    private func setupConstraints() {
        setupColorNameLabelConstraints()
        setupChangeColorButtonConstraints()
    }
    
    private func setupColorNameLabelConstraints() {
        NSLayoutConstraint.activate(
            [
                colorNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                colorNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            ]
        )
    }
    
    
    private func setupChangeColorButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                changeColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                changeColorButton.topAnchor.constraint(equalTo: colorNameLabel.bottomAnchor, constant: 20),
                
            ]
        )
    }
    
    private func setupActions() {
        changeColorButton.addAction(UIAction(handler: { [weak self] _ in
            self?.handleButtonTap()
        }), for: .touchUpInside)
    }
    
    private func handleButtonTap() {
        guard let random = colors.randomElement() else { return }
        view.backgroundColor = random.color
        colorNameLabel.backgroundColor = random.color
        colorNameLabel.text = "Color: \(random.name)"
    }
}
