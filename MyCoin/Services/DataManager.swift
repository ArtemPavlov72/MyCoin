//
//  DataManager.swift
//  MyCoin
//
//  Created by Artem Pavlov on 11.01.2023.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    let fakeUser = User(name: "1234", password: "1234", isRegistered: true)
    //private let url = "https://data.messari.io/api/v1/assets/btc/metrics"
    
    let coins = [
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
    
    func getURL() -> [String] {
        var urls: [String] = []
        
        for coin in coins {
            let url = Link.baseUrl.rawValue + coin + Link.metrics.rawValue
            urls.append(url)
        }
        return urls
    }
}

extension DataManager {
    enum Link: String {
        case baseUrl = "https://data.messari.io/api/v1/assets/"
        case metrics = "/metrics"
    }
}

