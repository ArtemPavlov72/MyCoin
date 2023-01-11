//
//  User.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

struct User: Codable {
    let name: String
    let password: String
    let isRegistered: Bool
}
