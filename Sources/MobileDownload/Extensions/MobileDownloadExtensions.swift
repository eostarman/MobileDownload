//
//  File.swift
//  
//
//  Created by Michael Rutherford on 1/8/21.
//

import Foundation
import MoneyAndExchangeRates

extension MobileDownload {
    /// convert an amount in one currency to a different currency (assuming the most-recent conversion rate)
    /// - Parameters:
    ///   - amount: the amount with a currency
    ///   - currency: the required currency
    public func exchange(_ amount: Money, to currency: Currency, numberOfDecimals: Int) -> Money? {
        if amount.currency == currency {
            return amount
        }
        
        guard let convertedPrice = handheld.exchangeRates.getMoney(from: amount, to: currency, date: .distantFuture, numberOfDecimals: numberOfDecimals) else {
            return nil
        }
        
        return convertedPrice
    }
}
