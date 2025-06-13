import Foundation


let books = [
    ["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
    ["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
    ["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
    ["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
    ["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
]

var discountedPrices: [Double] = books
    .compactMap { book in
        if let price = book["price"] as? Int {
            return Double(price) * 0.9
        }
        return nil
    }

print(discountedPrices)

var booksPostedAfter2000: [String] = books
    .filter({ $0["year"] as! Int > 2000})
    .compactMap({$0["title"] as? String})

print(booksPostedAfter2000)

var allGenres: Set<String> = Set(books
    .flatMap({$0["genre"] as? [String] ?? []}))

print(allGenres)

var totalCost: Int = books
    .reduce(0) { sum, book in
        sum + (book["price"] as! Int)
    }

print(totalCost)
