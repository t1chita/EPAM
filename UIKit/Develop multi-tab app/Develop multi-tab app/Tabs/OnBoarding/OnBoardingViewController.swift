//
//  OnBoardingViewController.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//


import UIKit

final class OnBoardingViewController: UIViewController {
    private lazy var startButton: BaseButton = {
        let button = BaseButton()
        button.configure(
            withColor: .blue,
            title: "Start"
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelfView()
        setupViews()
        setupActions()
    }
    
    private func setupSelfView() {
        view.backgroundColor = .purple
    }
    
    private func setupViews() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(startButton)
    }
    
    private func setupConstraints() {
        setupStartButtonConsraints()
    }
    
    private func setupStartButtonConsraints() {
        NSLayoutConstraint.activate(
            [
                startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        )
    }
    
    private func setupActions() {
        startButton.addAction(UIAction(handler: { [weak self] _ in
            self?.handleButtonTap()
        }), for: .touchUpInside)
    }
    
    private func handleButtonTap() {
        self.navigationController?.pushViewController(PersonalInfoViewController(),
                                                      animated: true)
    }
    
    func updateForRestartedState() {
        startButton.setTitle("Restart", for: .normal)
        startButton.backgroundColor = .systemGreen
    }
}
