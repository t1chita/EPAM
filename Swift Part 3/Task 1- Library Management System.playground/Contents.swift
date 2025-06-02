import Foundation

protocol Borrowable: AnyObject {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }

    func checkIn()
    func isOverdue() -> Bool
}

extension Borrowable {
    func isOverdue() -> Bool {
        guard let returnDate else { return false }
        return returnDate < Date()
    }

    func checkIn() {
        isBorrowed = false
        borrowDate = nil
        returnDate = nil
    }
}

class Item {
    let id: String = UUID().uuidString
    let author: String
    let title: String

    init(author: String, title: String) {
        self.author = author
        self.title = title
    }
}

final class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool

    init(
        borrowDate: Date? = nil,
        returnDate: Date? = nil,
        isBorrowed: Bool,
        author: String,
        title: String
    ) {
        self.borrowDate = borrowDate
        self.returnDate = returnDate
        self.isBorrowed = isBorrowed
        super.init(author: author, title: title)
    }
}

enum LibraryError: Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
}

final class Library {
    var storedItems: [String: Item] = [:]

    func addBook(_ book: Book) {
        storedItems[book.id] = book
    }

    func borrowItem(by id: String) throws -> Item {
        guard let item = storedItems[id] else {
            throw LibraryError.itemNotFound
        }

        guard let borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }

        if borrowableItem.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }

        borrowableItem.isBorrowed = true
        borrowableItem.borrowDate = Date()
        borrowableItem.returnDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())

        return item
    }
}
