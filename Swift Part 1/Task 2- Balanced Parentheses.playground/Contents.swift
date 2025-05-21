import Foundation

// Task 2: BalancedParentheses

/// - Only parentheses () are considered; other brackets or characters should be ignored.
/// - The input string might contain multiple lines.
/// - For example, "(())" is balanced, but "(()" is not.

public func isBalancedParentheses(input: String) -> Bool {
    let s = input.filter({ $0 == "(" || $0 == ")"})
    
    if s.isEmpty {
        return false
    }
    
    var stack: [Character] = []
    
    for char in s {
        if stack.last == "(" && char == ")" {
            stack.removeLast()
        } else {
            stack.append(char)
        }
    }
    
    if stack.isEmpty {
        return true
    } else {
        return false
    }
}


// ✅ Balanced cases
print(isBalancedParentheses(input: "()"))                  // true
print(isBalancedParentheses(input: "(())"))                // true
print(isBalancedParentheses(input: "()()"))                // true
print(isBalancedParentheses(input: "(((())))"))            // true
print(isBalancedParentheses(input: "abc(def(ghi))"))       // true
print(isBalancedParentheses(input: "\n(\n(\n)\n)\n"))      // true
print(isBalancedParentheses(input: "(a + b) * (c + d)"))   // true

// ❌ Unbalanced cases
print(isBalancedParentheses(input: "("))                   // false
print(isBalancedParentheses(input: ")("))                  // false
print(isBalancedParentheses(input: "(()"))                 // false
print(isBalancedParentheses(input: "())"))                 // false
print(isBalancedParentheses(input: "(()))("))              // false
print(isBalancedParentheses(input: "hello world"))         // false
print(isBalancedParentheses(input: ""))                    // false
print(isBalancedParentheses(input: "(a + b"))              // false
  
