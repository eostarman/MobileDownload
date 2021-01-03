//
//  PromoItem.swift
//  MobileBench
//
//  Created by Michael Rutherford on 7/21/20.
//

import Foundation
import MoneyAndExchangeRates

public struct PromoItem: Codable {
    public enum ePromoRateType: Int, Codable {
        case amountOff = 0
        case percentOff = 1
        case promoPrice = 2
    }

    public var promoSectionNid: Int = 0

    public var itemNid: Int = 0
    public var isExplicitTriggerItem: Bool = false
    public var triggerGroup: Int = 0
    public var promoRateType: ePromoRateType = .promoPrice
    public var promoRate: Int = 0
    public var fromDateOverride: Date?
    public var thruDateOverride: Date?

    public init() { }

    public var hasDiscount: Bool {
        switch promoRateType {
        case .amountOff: return promoRate != 0
        case .percentOff: return promoRate != 0
        case .promoPrice: return true
        }
    }

    public func getPercentOff() -> Double {
        Double(promoRate) / 10000 // 4 decimal percentage - return 3.5% as 3.5000
    }

    public func getAmountOff(currency: Currency) -> Money {
        Money(scaledAmount: promoRate, numberOfDecimals: 4, currency: currency) // 4 decimal percentage
    }

    public func getPromoPrice(currency: Currency) -> Money {
        Money(scaledAmount: promoRate, numberOfDecimals: 4, currency: currency) // 4 decimal percentage
    }

}
