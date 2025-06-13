import Foundation

struct Stack<T> {
    var stack: [T] = []
    
    mutating
    func push(_ element: T) {
        stack.append(element)
    }
    
    mutating
    func pop() -> T? {
        stack.popLast()
    }
    
    func size() -> Int {
        stack.count
    }
    
    func printStackContents() -> String {
        stack.map { "\($0)" }.joined(separator: ", ")
    }
}
