//
//  UserManager.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    var name: String = ""
    var number: String = ""
    var preference: String = ""
    var hasOnboarded: Bool = false
    
    private init() {}
    
    func reset() {
        name = ""
        number = ""
        preference = ""
        hasOnboarded = false
    }
}
