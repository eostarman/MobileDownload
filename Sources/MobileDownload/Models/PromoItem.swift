//
//  PromoItem.swift
//  MobileBench
//
//  Created by Michael Rutherford on 7/21/20.
//

import Foundation
import MoneyAndExchangeRates

public class PromoItem: Codable {
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
    public var unitRebate: MoneyWithoutCurrency = .zero // this is not downloaded as part of the MobileDownload
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
    
    /// Create a promo item that provides a percent-off discount (a 3.5% discount is entered as 3.5, not .035)
    public init(_ item: ItemRecord, percentOff: Double, triggerGroup: Int? = nil) {
        self.itemNid = item.recNid
        self.promoRate = Int(10000 * percentOff)
        self.promoRateType = .percentOff
        
        if let triggerGroup = triggerGroup {
            self.isExplicitTriggerItem = true
            self.triggerGroup = triggerGroup
        }
    }
    
    /// Create a promo item with an amount off such as $.75 off - the currency is taken from the promoCode
    public init(_ item: ItemRecord, amountOff: MoneyWithoutCurrency, triggerGroup: Int? = nil) {
        self.itemNid = item.recNid
        self.promoRate = Int(amountOff.scaledTo(numberOfDecimals: 4).scaledAmount)
        self.promoRateType = .amountOff
        
        if let triggerGroup = triggerGroup {
            self.isExplicitTriggerItem = true
            self.triggerGroup = triggerGroup
        }
    }
    
    /// Create a promo item that provides a specific price - e.g. the item has a promoted price of $8.54 - the currency is taken from the promoCode
    public init(_ item: ItemRecord, promotedPrice: MoneyWithoutCurrency, triggerGroup: Int? = nil) {
        self.itemNid = item.recNid
        self.promoRate = Int(promotedPrice.scaledTo(numberOfDecimals: 4).scaledAmount)
        self.promoRateType = .promoPrice
        
        if let triggerGroup = triggerGroup {
            self.isExplicitTriggerItem = true
            self.triggerGroup = triggerGroup
        }
    }
    
    public var is100PercentOff: Bool {
        promoRate == 100_0000
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
