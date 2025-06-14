//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    private let topView = UIView()
    private let bottomView = UIView()
    
    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    private var activeConstraints: [NSLayoutConstraint] = [] {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(activeConstraints)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupViews()
        registerForTraitChanges()
    }
    
    private func addSubviews() {
        view.addSubview(topView)
        view.addSubview(bottomView)
    }
    
    private func setupViews() {
        setupViewProperties()
        setupCommonConstraints()
        setupVerticalConstraints()
        setupHorizontalConstraints()
        updateConstraintsForCurrentTraits()
    }
    
    private func setupViewProperties() {
        topView.backgroundColor = .systemBlue
        bottomView.backgroundColor = .systemOrange
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCommonConstraints() {
        let commonConstraints = [
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]
        
        verticalConstraints += commonConstraints
        horizontalConstraints += commonConstraints
    }
    
    private func setupVerticalConstraints() {
        verticalConstraints += [
            topView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -16),
            topView.heightAnchor.constraint(equalTo: bottomView.heightAnchor)
        ]
    }
    
    private func setupHorizontalConstraints() {
        horizontalConstraints += [
            topView.trailingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: -16),
            topView.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            topView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bottomView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            self.updateConstraintsForCurrentTraits()
        }
    }
    
    private func updateConstraintsForCurrentTraits() {
        if traitCollection.horizontalSizeClass == .compact {
            if traitCollection.verticalSizeClass == .regular {
                // Compact width, Regular height (portrait)
                activeConstraints = verticalConstraints
            } else {
                // Compact width, Compact height (landscape)
                activeConstraints = horizontalConstraints
            }
        }
    }
}

#Preview {
    Task4ViewController()
}
