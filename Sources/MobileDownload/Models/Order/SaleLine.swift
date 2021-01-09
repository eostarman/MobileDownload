//
//  SaleLine.swift
//  MobileBench
//
//  Created by Michael Rutherford on 7/22/20.
//

import Foundation
import MoneyAndExchangeRates

// the sale of an item to a customer
public class SaleLine: Identifiable {
    public let id: Int
    public var itemNid: Int
    public var qtyOrdered: Int
    public var unitPrice: Money?
    public var unitDisc: Money?
    public var bestDiscountWithReason: DiscountWithReason?
    public var discountsWithReasons: [DiscountWithReason] = []

    public init(id: Int, itemNid: Int, qtyOrdered: Int, unitPrice: Money) {
        self.id = id
        self.itemNid = itemNid
        self.qtyOrdered = qtyOrdered
        self.unitPrice = unitPrice
    }

    public func clearDiscounts() {
        discountsWithReasons = []
        bestDiscountWithReason = nil
        unitDisc = nil
    }
    
    public func addDiscount(discount: DiscountWithReason) {
        discountsWithReasons.append(discount)
    }

    public func setBestDiscount() {
        bestDiscountWithReason = nil
        unitDisc = nil
        
        guard let currency = unitPrice?.currency else {
            return
        }
        
        for discountWithReason in discountsWithReasons {
            guard let amountOffInProperCurrency = mobileDownload.exchange(discountWithReason.amountOff, to: currency) else {
                continue
            }
            
            if unitDisc == nil || amountOffInProperCurrency > unitDisc! {
                bestDiscountWithReason = discountWithReason
                unitDisc = amountOffInProperCurrency
            }
        }
    }
}
