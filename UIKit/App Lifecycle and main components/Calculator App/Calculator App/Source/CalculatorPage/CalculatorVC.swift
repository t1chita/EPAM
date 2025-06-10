//
//  CalculatorVC.swift
//  Calculator App
//
//  Created by Temur Chitashvili on 10.06.25.
//

import UIKit

final class CalculatorVC: UIViewController {
    private lazy var displayBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .numbersDisplayBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var clearButton: BaseButton = {
        let button: BaseButton = BaseButton()
        button.configure(
            withColor: .clear,
            title: "Clear All",
            titleColor: .white,
            borderWidth: 4,
            borderColor: .operators
        )
        return button
    }()
    
    private lazy var display: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .right
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()
    
    private lazy var calculatorContainer: UIStackView = {
        let container: UIStackView = .init()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .horizontal
        container.distribution = .fillProportionally
        container.alignment = .fill
        container.spacing = 8
        return container
    }()
    
    private lazy var calculatorContainerWithClearAllButton: UIStackView = {
        let container: UIStackView = .init()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.distribution = .fillProportionally
        container.alignment = .fill
        container.spacing = 16
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
        ["+", "-", "*", "/", "%", "="].map { symbol in
            ButtonModel(
                title: symbol,
                color: .operators) {
                    self.handleOperatorInput(forOperator: symbol)
                }
        }
    }()
    
    // Calculator state variables
    private var shouldResetDisplay = false
    private var lastResult: Double?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .background
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        displayBackground.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16)
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
        setUpCalculatorContainerWithClearAllButtonConstraints()
        setupDotButtonConstraints()
        setupZeroButtonConstraints()
        setUpDisplayBackgroundConstraints()
        setUpNumbersDisplayConstraints()
    }
    
    private func handleActions() {
        dotButtonActions()
        zeroButtonActions()
        setUpClearAllButtonAction()
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
            zeroButton.widthAnchor.constraint(equalTo: numberButtonsContainer.widthAnchor, multiplier: 0.66)
        ])
    }
    
    private func setupDotButtonConstraints() {
        NSLayoutConstraint.activate([
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
    
    private func setUpCalculatorContainerWithClearAllButtonConstraints() {
        view.addSubview(calculatorContainerWithClearAllButton)
        
        calculatorContainerWithClearAllButton.addArrangedSubview(clearButton)
        calculatorContainerWithClearAllButton.addArrangedSubview(calculatorContainer)
        calculatorContainer.addArrangedSubview(numberButtonsContainer)
        calculatorContainer.addArrangedSubview(operatorsContainer)
        
        NSLayoutConstraint.activate([
            calculatorContainerWithClearAllButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            calculatorContainerWithClearAllButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calculatorContainerWithClearAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calculatorContainerWithClearAllButton.heightAnchor.constraint(equalToConstant: 360)
        ])
    }
    
    private func setUpClearAllButtonAction() {
        clearButton.addAction(UIAction { [weak self] _ in
            self?.handleClearAllButtonTap()
        }, for: .touchUpInside)
    }
    
    private func setUpDisplayBackgroundConstraints() {
        view.addSubview(displayBackground)
        
        NSLayoutConstraint.activate(
            [
                displayBackground.topAnchor.constraint(equalTo: view.topAnchor),
                displayBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                displayBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                displayBackground.bottomAnchor.constraint(equalTo: calculatorContainerWithClearAllButton.topAnchor, constant: -200)
            ]
        )
    }
    
    private func setUpNumbersDisplayConstraints() {
        displayBackground.addSubview(display)
        
        NSLayoutConstraint.activate([
            display.bottomAnchor.constraint(equalTo: displayBackground.bottomAnchor, constant: -20),
            display.leadingAnchor.constraint(equalTo: displayBackground.leadingAnchor),
            display.trailingAnchor.constraint(equalTo: displayBackground.trailingAnchor, constant: -20),
        ])
    }
    
    private func handleNumberButtonTap(forNumber number: Int) {
        if shouldResetDisplay || display.text == "0" {
            display.text = "\(number)"
            shouldResetDisplay = false
        } else {
            display.text?.append("\(number)")
        }
    }
    
    private func handleOperatorInput(forOperator myOperator: String) {
        guard let text = display.text, !text.isEmpty else { return }
        
        if myOperator == "=" {
            calculateResult()
            return
        }
        
        // Prevent multiple consecutive operators
        if text.last == "+" || text.last == "-" || text.last == "*" || text.last == "/" || text.last == "%" {
            return
        }
        
        // Don't add operator if display is "0" (except for negative numbers)
        if text == "0" && myOperator != "-" {
            return
        }
        
        shouldResetDisplay = false
        display.text?.append(myOperator)
    }
    
    private func handleDotButtonTap() {
        guard let text = display.text else { return }
        
        if shouldResetDisplay {
            display.text = "0."
            shouldResetDisplay = false
            return
        }
        
        // Find the last number in the expression to check if it already has a decimal point
        let components = text.components(separatedBy: CharacterSet(charactersIn: "+-*/%"))
        if let lastComponent = components.last, !lastComponent.contains(".") {
            display.text?.append(".")
        }
    }
    
    private func handleClearAllButtonTap() {
        display.text = "0"
        shouldResetDisplay = false
        lastResult = nil
    }
    
    private func calculateResult() {
        guard let expression = display.text, !expression.isEmpty else { return }
        
        // Handle case where expression ends with an operator
        var cleanExpression = expression
        if let last = cleanExpression.last, "+-*/%".contains(last) {
            cleanExpression = String(cleanExpression.dropLast())
        }
        
        do {
            let result = try evaluateExpression(cleanExpression)
            
            // Format the result to remove unnecessary decimal places
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                display.text = String(format: "%.0f", result)
            } else {
                display.text = String(format: "%.10g", result)
            }
            
            lastResult = result
            shouldResetDisplay = true
            
        } catch CalculatorError.divisionByZero {
            display.text = "Cannot divide by zero"
            shouldResetDisplay = true
        } catch CalculatorError.moduloByZero {
            display.text = "Cannot modulo by zero"
            shouldResetDisplay = true
        } catch {
            display.text = "Error"
            shouldResetDisplay = true
        }
    }
    
    private func evaluateExpression(_ expression: String) throws -> Double {
        // Check for division by zero and modulo by zero before evaluation
        try checkForZeroDivision(in: expression)
        
        // Replace % with a custom modulo function since NSExpression doesn't support %
        let processedExpression = try processModuloOperations(expression)
        
        let expr = NSExpression(format: processedExpression)
        
        guard let result = expr.expressionValue(with: nil, context: nil) as? Double else {
            throw CalculatorError.invalidExpression
        }
        
        // Check for invalid results
        if result.isInfinite || result.isNaN {
            throw CalculatorError.mathError
        }
        
        return result
    }
    
    private func checkForZeroDivision(in expression: String) throws {
        // Check for division by zero patterns
        let divisionPatterns = ["/0", "/ 0", "/0.", "/ 0."]
        let moduloPatterns = ["%0", "% 0", "%0.", "% 0."]
        
        for pattern in divisionPatterns {
            if expression.contains(pattern) {
                // Additional check to ensure it's actually zero and not part of a larger number
                let components = expression.components(separatedBy: "/")
                for i in 1..<components.count {
                    let operand = components[i].trimmingCharacters(in: .whitespaces)
                    if let value = Double(operand), value == 0.0 {
                        throw CalculatorError.divisionByZero
                    }
                    // Check if the operand starts with 0 and is effectively zero
                    if operand.hasPrefix("0") && (operand == "0" || operand == "0.0" || operand == "0.") {
                        throw CalculatorError.divisionByZero
                    }
                }
            }
        }
        
        for pattern in moduloPatterns {
            if expression.contains(pattern) {
                // Additional check for modulo by zero
                let components = expression.components(separatedBy: "%")
                for i in 1..<components.count {
                    let operand = components[i].trimmingCharacters(in: .whitespaces)
                    if let value = Double(operand), value == 0.0 {
                        throw CalculatorError.moduloByZero
                    }
                    // Check if the operand starts with 0 and is effectively zero
                    if operand.hasPrefix("0") && (operand == "0" || operand == "0.0" || operand == "0.") {
                        throw CalculatorError.moduloByZero
                    }
                }
            }
        }
    }
    
    private func processModuloOperations(_ expression: String) throws -> String {
        var result = expression
        
        // Handle modulo operations since NSExpression doesn't support %
        while result.contains("%") {
            // Find the modulo operation
            guard let range = result.range(of: "%") else { break }
            
            // Extract left operand
            let beforeModulo = String(result[..<range.lowerBound])
            let afterModulo = String(result[range.upperBound...])
            
            // Find the left number
            var leftStart = beforeModulo.endIndex
            var leftNumber = ""
            
            for char in beforeModulo.reversed() {
                if char.isNumber || char == "." {
                    leftNumber = String(char) + leftNumber
                    leftStart = result.index(before: leftStart)
                } else {
                    break
                }
            }
            
            // Find the right number
            var rightEnd = afterModulo.startIndex
            var rightNumber = ""
            
            for char in afterModulo {
                if char.isNumber || char == "." {
                    rightNumber += String(char)
                    rightEnd = afterModulo.index(after: rightEnd)
                } else {
                    break
                }
            }
            
            guard let left = Double(leftNumber), let right = Double(rightNumber) else {
                throw CalculatorError.invalidExpression
            }
            
            if right == 0 {
                throw CalculatorError.moduloByZero
            }
            
            let moduloResult = left.truncatingRemainder(dividingBy: right)
            
            // Replace the modulo operation with the result
            let beforeRange = result[..<leftStart]
            let afterRange = afterModulo[rightEnd...]
            
            result = String(beforeRange) + String(moduloResult) + String(afterRange)
        }
        
        return result
    }
}
