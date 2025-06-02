import Foundation

struct School {
    enum SchoolRole {
        case student
        case teacher
        case administrator
    }
    
    class Person {
        var name: String
        var role: SchoolRole
        
        init(
            name: String,
            role: SchoolRole
        ) {
            self.name = name
            self.role = role
        }
    }
    
    private var people: [Person] = []
    
    mutating
    func addPerson(person: Person) {
        people.append(person)
    }
    
    subscript(role: SchoolRole) -> [Person] {
        people.filter({$0.role == role})
    }
    
    func countStudents(forSchool school: Self) -> Int {
        school[.student].count
    }
    
    func countTeachers(forSchool school: Self) -> Int {
        school[.teacher].count
    }
    
    func countAdministrators(forSchool school: Self) -> Int {
        school[.administrator].count
    }
}
