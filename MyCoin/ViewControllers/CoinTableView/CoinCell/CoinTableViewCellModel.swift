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
    init(coin: Coin)
}

class CoinTableViewCellModel: CoinCellViewModelProtocol {
    var coinName: String {
        coin.data.name
    }
    
    var coinPrice: String {
        formatNumber(number: coin.data.market_data.price_usd)
    }
    
    var coinChange: String {
        String(format: "%.2f", coin.data.market_data.percent_change_usd_last_1_hour) + " %"
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
