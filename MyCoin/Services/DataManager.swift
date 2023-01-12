//
//  DataManager.swift
//  MyCoin
//
//  Created by Artem Pavlov on 11.01.2023.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    let fakeUser = User(name: "1234", password: "1234", isRegistered: true)
    
    private init() {}
}
