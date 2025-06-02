import Foundation

class Person {
    let name: String
    let age: Int
    
    lazy var profileDescription: String = {
        return "\(name) is \(age) years old."
    }()
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    init?(validatedName name: String, age: Int) {
        guard age >= 16 else {
            return nil
        }
        self.name = name
        self.age = age
    }
}

final class Student: Person {
    let studentID: String
    let major: String

    private nonisolated(unsafe) static var studentCount = 0

    weak var advisor: Professor?
    
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        Student.studentCount += 1  // increment count whenever a student is created
    }
    
    convenience init(name: String, age: Int, studentID: String) {
        self.init(name: name, age: age, studentID: studentID, major: "Undeclared")
    }
    
    deinit {
        Student.studentCount -= 1
    }
}

final class Professor: Person {
    let faculty: String

    private nonisolated(unsafe) static var professorCount = 0

    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        Professor.professorCount += 1
    }
    
    deinit {
        Professor.professorCount -= 1
    }
}

struct University {
    let name: String
    let location: String
}


//MARK: - Task 3 University Student Management System – Extended Version
extension Person {
    var isAdult: Bool {
        age >= 18
    }
    
    static let minAgeForEnrollment = 16
}


extension Student {
    var formattedID: String {
        return "ID: \(studentID.uppercased())"
    }
}

extension Professor {
    var fullTitle: String {
        return "Full Title: \(faculty) Professor"
    }
}

extension University {
    var description: String {
        return "\(name) is located in \(location)."
    }
}
