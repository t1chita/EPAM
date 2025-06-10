//
//  CalculatorVC.swift
//  Calculator App
//
//  Created by Temur Chitashvili on 10.06.25.
//

import UIKit

final class CalculatorVC: UIViewController {
    
    private lazy var calculatorContainer: UIStackView = {
        let container: UIStackView = .init()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .horizontal
        container.distribution = .fillProportionally
        container.alignment = .fill
        container.spacing = 8
        return container
    }()
    
    private lazy var zeroAndDotContainer: UIStackView = {
        let container: UIStackView = .init()
        container.axis = .horizontal
        container.distribution = .fillProportionally
        container.alignment = .fill
        container.spacing = 8
        return container
    }()
    
    private lazy var zeroButton: BaseButton = {
        let button: BaseButton = BaseButton()
        button.configure(withColor: .number, title: "0")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dotButton: BaseButton = {
        let button: BaseButton = BaseButton()
        button.configure(withColor: .number, title: ".")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var numberButtonsContainer: UIStackView = {
        let container: UIStackView = .init()
        container.axis = .vertical
        container.distribution = .fillEqually
        container.alignment = .fill
        container.spacing = 8
        return container
    }()
    
    private lazy var operatorsContainer: UIStackView = {
        let container: UIStackView = .init()
        container.axis = .vertical
        container.distribution = .fillEqually
        container.alignment = .fill
        container.spacing = 8
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return container
    }()
    
    private lazy var numbers: [ButtonModel] = {
        let numbers: [ButtonModel] = (1...9).map { number in
            return ButtonModel(
                title: String(number),
                color: .number) { [weak self] in
                    self?.handleNumberButtonTap(forNumber: number)
                }
        }
        return numbers
    }()
    
    private lazy var operators: [ButtonModel] = {
        ["+", "-", "*", "/", "="].map { symbol in
            ButtonModel(
                title: symbol,
                color: .operators) {
                    self.handleOperatorInput(forOperator: symbol)
                }
        }
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .background
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleActions()
    }
    
    private func setupUI() {
        setupButtonsGrid()
        setupOperatorsGrid()
        setupConstraints()
    }
    
    private func setupConstraints() {
        setUpCalculatorContainerConstraints()
        setupDotButtonConstraints()
        setupZeroButtonConstraints()
    }
    
    private func handleActions() {
        dotButtonActions()
        zeroButtonActions()
    }
    
    private func setupButtonsGrid() {
        for row in stride(from: 0, to: numbers.count, by: 3) {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.alignment = .fill
            rowStack.spacing = 8
            
            let models = Array(numbers[row..<min(row + 3, numbers.count)])
            
            for model in models {
                let button = BaseButton()
                button.configure(
                    withColor: model.color,
                    title: model.title
                )
                button.addAction(UIAction { _ in
                    model.action()
                }, for: .touchUpInside)
                
                rowStack.addArrangedSubview(button)
            }
            
            numberButtonsContainer.addArrangedSubview(rowStack)
        }
        
        zeroAndDotContainer.addArrangedSubview(zeroButton)
        zeroAndDotContainer.addArrangedSubview(dotButton)
        numberButtonsContainer.addArrangedSubview(zeroAndDotContainer)
    }
    
    private func setupZeroButtonConstraints() {
        NSLayoutConstraint.activate([
            zeroButton.heightAnchor.constraint(equalToConstant: 56),
            zeroButton.widthAnchor.constraint(equalTo: numberButtonsContainer.widthAnchor, multiplier: 0.66)
        ])
    }
    
    private func setupDotButtonConstraints() {
        NSLayoutConstraint.activate([
            dotButton.heightAnchor.constraint(equalToConstant: 56),
            dotButton.widthAnchor.constraint(equalTo: numberButtonsContainer.widthAnchor, multiplier: 0.33)
        ])
    }
    
    private func zeroButtonActions() {
        zeroButton.addAction(UIAction { [weak self] _ in
            self?.handleNumberButtonTap(forNumber: 0)
        }, for: .touchUpInside)
    }
    
    private func dotButtonActions() {
        dotButton.addAction(UIAction { [weak self] _ in
            self?.handleDotButtonTap()
        }, for: .touchUpInside)
    }
    
    private func setupOperatorsGrid() {
        for myOperator in operators {
            let button = BaseButton()
            button.configure(
                withColor: myOperator.color,
                title: myOperator.title
            )
            button.addAction(UIAction { _ in
                myOperator.action()
            }, for: .touchUpInside)
            operatorsContainer.addArrangedSubview(button)
        }
    }
    
    private func setUpCalculatorContainerConstraints() {
        view.addSubview(calculatorContainer)
        
        calculatorContainer.addArrangedSubview(numberButtonsContainer)
        calculatorContainer.addArrangedSubview(operatorsContainer)
        
        NSLayoutConstraint.activate([
            calculatorContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            calculatorContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calculatorContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calculatorContainer.heightAnchor.constraint(equalToConstant: 360)
        ])
    }
    
    private func handleNumberButtonTap(forNumber number: Int) {
        print("Number \(number) tapped")
    }
    
    private func handleOperatorInput(forOperator myOperator: String) {
        print("Operator \(myOperator) tapped")
    }
    
    private func handleDotButtonTap() {
        print("Dot tapped")
    }
}

struct ButtonModel {
    let title: String
    let color: UIColor
    let action: () -> Void
}

final class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        withColor color: UIColor,
        title: String,
        titleColor: UIColor = .white,
        titleFont: UIFont = .systemFont(ofSize: 24, weight: .medium),
        cornerRadius: CGFloat = 8,
        textAlignment: NSTextAlignment = .center
    ) {
        self.titleLabel?.textAlignment = textAlignment
        self.titleLabel?.font = titleFont
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
