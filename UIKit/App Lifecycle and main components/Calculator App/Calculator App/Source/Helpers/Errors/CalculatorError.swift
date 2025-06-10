//
//  CalculatorError.swift
//  Calculator App
//
//  Created by Temur Chitashvili on 10.06.25.
//

import Foundation

enum CalculatorError: Error {
    case invalidExpression
    case mathError
    case divisionByZero
    case moduloByZero
}
