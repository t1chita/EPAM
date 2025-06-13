import Foundation

struct User {
    let username: String
    let email: String
    let password: String
}

class UserManager {
    var users: [String: User] = [:]
    
    func registerUser(username: String,
                      email: String,
                      password: String) -> Bool {
        guard users[username] == nil else { return false }
        
        let user = User(username: username,
                        email: email,
                        password: password)
        
        users[username] = user
        
        return true
    }
    
    func login(username: String,
               password: String) -> Bool {
        
        if let user = users[username] {
            if user.password == password {
                return true
            }
        }
        
        return false
    }
    
    func removeUser(username: String) -> Bool {
        if let user = users[username] {
            users[username] = nil
            return true
        }
        
        return false
    }
    
    var userCount: Int {
        return users.count
    }
}

final class AdminUser: UserManager {
    func listAllUsers() -> [String] {
        return Mirror(reflecting: self).children
            .compactMap { label, value in
                if label == "users", let dict = value as? [String: User] {
                    return Array(dict.keys)
                }
                
                return nil
            }
            .flatMap { $0 }
    }
    
     deinit {
         print("AdminUser instance is being deinitialized.")
     }
}

let admin = AdminUser()
admin.registerUser(username: "temur", email: "temur@example.com", password: "1234")
admin.registerUser(username: "john", email: "john@example.com", password: "abcd")

print("Login success:", admin.login(username: "temur", password: "1234"))
print("User count:", admin.userCount)
print("All users:", admin.listAllUsers())
print("Removing user:", admin.removeUser(username: "john"))
