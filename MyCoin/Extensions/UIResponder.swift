//
//  UIResponder.swift
//  MyCoin
//
//  Created by Артем Павлов on 02.02.2023.
//

import UIKit

extension UIResponder {
    func formatNumber(number: Double?, fixLenght: Bool = true) -> String {
        guard let number = number as? NSNumber else { return "Not a number" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = fixLenght ? 4 : 0
        
        guard let formattedNumber = formatter.string(from: number) else { return "Formatting error" }
        let numberWithFixLenghtOfDigit = String(formattedNumber.prefix(9))
        let resultNumber = fixLenght ? numberWithFixLenghtOfDigit : formattedNumber
        
        return resultNumber + " $"
    }
}
