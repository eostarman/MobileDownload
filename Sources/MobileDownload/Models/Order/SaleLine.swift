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
    public var price: Money?

    public init(id: Int, itemNid: Int, qtyOrdered: Int, price: Money) {
        self.id = id
        self.itemNid = itemNid
        self.qtyOrdered = qtyOrdered
        self.price = price
    }

    public var bestDiscount: Discount?
    public var discounts: [Discount] = []

    public func clearDiscounts() { discounts = [] }
    public func addDiscount(discount: Discount) {
        discounts.append(discount)
    }

    public func setBestDiscount() {
        bestDiscount = discounts.first // not really - just a stub
    }
}
