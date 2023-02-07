//
//  UserManager.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    
    private let defaults = UserDefaults.standard
    private let userNotRegistered = User(name: "", password: "", isRegistered: false)
    
    private init() {}
    
    private func fetchData() -> User {
        guard let data = defaults.data(forKey: Key.user.rawValue) else { return userNotRegistered}
        guard let user = try? JSONDecoder().decode(User.self, from: data) else { return userNotRegistered }
        return user
    }
    
    func isRegistered() -> Bool {
        let user = fetchData()
        return user.isRegistered
    }
    
    func save(user: User) {
        guard let data = try? JSONEncoder().encode(user) else { return }
        defaults.set(data, forKey: Key.user.rawValue)
    }
    
    func deleteUserData() {
        defaults.removeObject(forKey: Key.user.rawValue)
        defaults.removeObject(forKey: Key.filter.rawValue)
    }
    
    func getFilterStatus() -> Bool {
        defaults.bool(forKey: Key.filter.rawValue)
    }
    
    func setFilterStatus(with status: Bool) {
        defaults.set(status, forKey: Key.filter.rawValue)
    }
}

extension UserManager {
    enum Key: String {
        case user = "user"
        case filter = "filterStatus"
    }
}
