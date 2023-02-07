//
//  CoinDetailsViewModel.swift
//  MyCoin
//
//  Created by Артем Павлов on 04.02.2023.
//

import Foundation

protocol CoinDetailsViewModelProtocol {
    var coinSymbol: String { get }
    var coinName: String { get }
    var coinPrice: String { get }
    var description: String { get }
    var rank: String { get }
    var coinRankInfo: String { get }
    var marketCap: String { get }
    var marketCapInfo: String { get }
    var coinChange1h: String { get }
    var coinChange1hInfo: String { get }
    var coinChange24h: String { get }
    var coinChange24hInfo: String { get }
    init(coin: Coin)
}

class CoinDetailsViewModel: CoinDetailsViewModelProtocol {
   
    //MARK: - Public Properties
    var coinSymbol: String {
        coin.data?.symbol ?? ""
    }
    
    var coinName: String {
        coin.data?.name ?? ""
    }
    
    var coinPrice: String {
        formatNumber(number: coin.data?.marketData?.priceUsd)
    }
    
    var description: String {
        "About \(coinSymbol)"
    }
    
    var rank: String {
        "Rank"
    }
    
    var coinRankInfo: String {
        coin.data?.marketcap?.rank?.description ?? ""
    }
    
    var marketCap: String {
        "Marketcap"
    }
    
    var marketCapInfo: String {
        formatNumber(
            number: coin.data?.marketcap?.currentMarketcapUsd,
            fixLenght: false
        )
    }
    
    var coinChange1h: String {
        "Changes in 1 hour"
    }
    
    var coinChange1hInfo: String {
        guard let coinChange = coin.data?.marketData?.percentChangeUsdLast1Hour else { return ""}
        return String(format: "%.2f", coinChange) + " %"
    }
    
    var coinChange24h: String {
        "Changes in 24 hours"
    }
    
    var coinChange24hInfo: String {
        guard let coinChange = coin.data?.marketData?.percentChangeUsdLast24Hours else { return ""}
        return String(format: "%.2f", coinChange) + " %"
    }
    
    required init(coin: Coin) {
        self.coin = coin
    }
    
    //MARK: - Private Properties
    private let coin: Coin
    
    //MARK: - Private Methods
    private func formatNumber(number: Double?, fixLenght: Bool = true) -> String {
        guard let number = number as? NSNumber else { return "Not a number" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = fixLenght ? 4 : 0
        
        guard let formattedNumber = formatter.string(from: number) else {
            return "Formatting error"
        }
        let numberWithFixLenghtOfDigit = String(formattedNumber.prefix(9))
        let resultNumber = fixLenght ? numberWithFixLenghtOfDigit : formattedNumber
        
        return resultNumber + " $"
    }
}
