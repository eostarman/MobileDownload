//
//  RetailPrices.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 12/24/20.
//

import Foundation
import MoneyAndExchangeRates

public struct CustomerRetailPrice: Codable { // aka ItemRetailPrice.cs
    public let itemNid: Int
    public let price: MoneyWithoutCurrency

    public init(itemNid: Int, price: MoneyWithoutCurrency) {
        self.itemNid = itemNid
        self.price = price
    }
}
