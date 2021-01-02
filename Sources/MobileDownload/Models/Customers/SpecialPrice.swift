//
//  SpecialPrice.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 12/23/20.
//

import Foundation
import MoneyAndExchangeRates

/// This represents a special price for the customer (during the date range, the prixe of the itemNid *will* be the special price) - even if there's a better price elsewhere.
/// Note that this is a special frontline price (discounts can still apply)
public struct SpecialPrice: Codable {
    public var startDate: Date = .distantPast
    public var endDate: Date?
    public var itemNid: Int = 0
    public var price: MoneyWithoutCurrency = .zero

    public init() { }

    public func isPriceActive(date: Date) -> Bool {
        if date < startDate {
            return false
        }

        if let endDate = endDate, date > endDate {
            return false
        }

        return true
    }
}
