import Foundation
// Task 1: Palindrome check
///   However, the trick is:
/// - The solution should ignore spaces, punctuation, capitalization and control characters.
/// - The solution should not use any third-party libraries or regular expressions.
/// - The solution should not consider an empty string or a single character as a palindrome.

public func isPalindrome(input: String) -> Bool {
    if input.count == 1 || input.isEmpty { return false }
    let s = input.filter({$0.isLetter || $0.isNumber}).lowercased()
    if s.isEmpty { return false }
    
    let array = Array(s)
    var left = 0
    var right = array.count - 1
    
    while left <= right {
        if array[left] != array[right] {
            return false
        }
        
        left += 1
        right -= 1
    }
    
    return true
}
