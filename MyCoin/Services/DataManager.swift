//
//  DataManager.swift
//  MyCoin
//
//  Created by Artem Pavlov on 11.01.2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let fakeUser = User(name: "1234", password: "1234", isRegistered: true)
    private let coins = [
        "btc",
        "eth",
        "tron",
        "luna",
        "polkadot",
        "dogecoin",
        "tether",
        "stellar",
        "cardano",
        "xrp"
    ]
    
    private init() {}
    
    func getURLs() -> [String] {
        var urls: [String] = []
        
        for coin in coins {
            let url = Link.baseUrl.rawValue + coin + Link.metrics.rawValue
            urls.append(url)
        }
        return urls
    }
    
    func getfakeUserName() -> String {
        fakeUser.name
    }
    
    func getFakeUserPassword() -> String {
        fakeUser.password
    }
}
