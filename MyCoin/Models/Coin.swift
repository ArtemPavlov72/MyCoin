//
//  Coin.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

struct Coin: Decodable {
    let data: CoinData?
}

struct CoinData: Decodable {
    let symbol: String?
    let name: String?
    let marketData: MarketData?
    let marketcap: Marketcap?
}

struct MarketData: Decodable {
    let priceUsd: Double?
    let percentChangeUsdLast1Hour: Double?
    let percentChangeUsdLast24Hours: Double?
}

struct Marketcap: Decodable {
    let rank: Int?
    let currentMarketcapUsd: Double?
}

enum Link: String {
    case baseUrl = "https://data.messari.io/api/v1/assets/"
    case metrics = "/metrics"
}


