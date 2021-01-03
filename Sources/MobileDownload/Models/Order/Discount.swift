//
//  File.swift
//  
//
//  Created by Michael Rutherford on 1/2/21.
//

import Foundation
import MoneyAndExchangeRates

public struct Discount {
    public let promoItem: PromoItem
    public let amountOff: Money

    public init(promoItem: PromoItem, amountOff: Money) {
        self.promoItem = promoItem
        self.amountOff = amountOff
    }
}
