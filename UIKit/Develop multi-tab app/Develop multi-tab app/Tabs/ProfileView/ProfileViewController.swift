//
//  ProfileViewController.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import UIKit

final class ProfileViewController: UIViewController {
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editProfileButton: BaseButton = {
        let button = BaseButton()
        button.configure(
            withColor: .white,
            title: "Edit Profile",
            isEnabled: UserManager.shared.hasOnboarded,
            titleColor: .black
        )
        return button
    }()
    
    private lazy var changeNameButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "pencil.slash"),
            style: .plain,
            target: self,
            action: #selector(didPersonTapEditName)
        )
        button.tintColor = .white
        button.isEnabled = UserManager.shared.hasOnboarded
        return button
    }()

    private lazy var anonymusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(didPersonTapAnonymus)
        )
        button.tintColor = .white
        button.isEnabled = UserManager.shared.hasOnboarded
        return button
    }()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelfView()
        setupViews()
        setupActions()
        
        NotificationCenter.default.addObserver(
             self,
             selector: #selector(handleOnboardingCompletion),
             name: .didCompleteOnboarding,
             object: nil
         )
    }
    
    private func setupSelfView() {
        view.backgroundColor = .blue
        navigationItem.title = "Profile"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
         navigationItem.rightBarButtonItems = [anonymusButton, changeNameButton]
    }
    
    private func setupViews() {
        addSubviews()
        setupConstraints()
        setupUserNameLabel()
    }
    
    private func addSubviews() {
        view.addSubview(userNameLabel)
        view.addSubview(editProfileButton)
    }
    
    private func setupConstraints() {
        setupUserNameConstraints()
        setupEditProfileButtonConstraints()
    }
    
    private func setupUserNameLabel() {
        if UserManager.shared.hasOnboarded {
            userNameLabel.text = "User Name \(UserManager.shared.name)"
        } else {
            userNameLabel.text = "Please onboard first"
        }
    }
    
    private func setupUserNameConstraints() {
        NSLayoutConstraint.activate(
            [
                userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                userNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    
    private func setupEditProfileButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                editProfileButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16)
            ]
        )
    }
    
    
    private func setupActions() {
        editProfileButton.addAction(UIAction(handler: { [weak self] _ in
            self?.handleEditProfileButtonTap()
        }), for: .touchUpInside)
    }
    
    private func handleEditProfileButtonTap() {
        let vc = EditProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleOnboardingCompletion() {
        updateUserNameLabel()
        changeNameButton.isEnabled = true
        anonymusButton.isEnabled = true
        editProfileButton.isEnabled = true
        editProfileButton.alpha = 1
    }
    
    @objc private func didPersonTapEditName() {
        let alert = UIAlertController(title: "Rename", message: "Enter a new name", preferredStyle: .alert)
          
          alert.addTextField { textField in
              textField.placeholder = "New name"
              textField.autocapitalizationType = .words
          }
          
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          
          let renameAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
              guard let newName = alert.textFields?.first?.text, !newName.isEmpty else { return }
              UserManager.shared.name = newName
              self?.updateUserNameLabel()
          }
          
          alert.addAction(cancelAction)
          alert.addAction(renameAction)
          
          present(alert, animated: true)
    }

    @objc private func didPersonTapAnonymus() {
        UserManager.shared.name = "Anonymous"
        userNameLabel.text = "User Name: \(UserManager.shared.name)"
    }
    
    
    private func updateUserNameLabel() {
        userNameLabel.text = "User Name: \(UserManager.shared.name)"
    }
}
