//
//  File.swift
//  
//
//  Created by Michael Rutherford on 2/9/21.
//

import Foundation
import MoneyAndExchangeRates

extension MoneyWithoutCurrency {

    public func converted(to currency: Currency, withDecimals numberofDecimals: Int, from fromCurrency: Currency) -> MoneyWithoutCurrency? {
        if fromCurrency == currency {
            return self
        }
        
        let money = self.withCurrency(fromCurrency)
        
        guard let result =  mobileDownload.exchange(money, to: currency) else {
            return nil
        }
        
        let roundedResult = result.withDecimals(numberOfDecimals).withoutCurrency()
        
        return roundedResult
    }
}
