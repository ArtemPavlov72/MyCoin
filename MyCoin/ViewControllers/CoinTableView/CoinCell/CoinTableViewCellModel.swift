//
//  CoinTableViewCellModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 03.02.2023.
//

import Foundation

protocol CoinCellViewModelProtocol {
    var coinName: String { get }
    var coinPrice: String { get }
    var coinChange: String { get }
    var isChangeGrow: Bool { get }
    init(coin: Coin)
}

class CoinTableViewCellModel: CoinCellViewModelProtocol {
    var coinName: String {
        coin.data?.name ?? ""
    }
    
    var coinPrice: String {
        formatNumber(number: coin.data?.marketData?.priceUsd)
    }
    
    var coinChange: String {
        guard let coinChange = coin.data?.marketData?.percentChangeUsdLast1Hour else { return "" }
        return String(format: "%.2f", coinChange) + " %"
    }
    var isChangeGrow: Bool {
        guard let coinChange = coin.data?.marketData?.percentChangeUsdLast1Hour else { return false }
        return coinChange < 0 ? false : true
    }
    
    private let coin: Coin
    
    private func formatNumber(number: Double?) -> String {
        guard let number = number as? NSNumber else { return "Not a number" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 4
        
        guard let formattedNumber = formatter.string(from: number) else { return "Formatting error" }
        let numberWithFixLenghtOfDigit = String(formattedNumber.prefix(9))
        
        return numberWithFixLenghtOfDigit + " $"
    }
    
    required init(coin: Coin) {
        self.coin = coin
    }
}
