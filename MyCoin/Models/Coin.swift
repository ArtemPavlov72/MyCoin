//
//  Coin.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

struct Coin: Codable {
    let data: CoinData
}

struct CoinData: Codable {
    let symbol: String
    let name: String
    let market_data: MarketData
    let marketcap: Marketcap
}

struct MarketData: Codable {
    let price_usd: Double
    let percent_change_usd_last_1_hour: Double
    let percent_change_usd_last_24_hours: Double
}

struct Marketcap: Codable {
    let rank: Int
    let current_marketcap_usd: Double
}

enum Link: String {
    case baseUrl = "https://data.messari.io/api/v1/assets/"
    case metrics = "/metrics"
}


