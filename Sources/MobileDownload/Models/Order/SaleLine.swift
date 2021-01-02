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

    public struct Discount {
        let mixAndMatchPromo: MixAndMatchPromo
        let promoItem: PromoItem
        public let amountOff: Money
    }

    public init(id: Int, itemNid: Int, qtyOrdered: Int, price: Money) {
        self.id = id
        self.itemNid = itemNid
        self.qtyOrdered = qtyOrdered
        self.price = price
    }

    public var bestDiscount: Discount?
    public var discounts: [Discount] = []

    public func clearDiscounts() { discounts = [] }
    public func addDiscount(mixAndMatchPromo: MixAndMatchPromo, promoItem: PromoItem) {
        guard let price = price else { return }
        let promoSection = mobileDownload.promoSections[promoItem.promoSectionNid]
        let promoCode = mobileDownload.promoCodes[promoSection.promoCodeNid]
        if let amountOff = promoItem.getUnitDisc(promoCode: promoCode, unitPrice: price, nbrPriceDecimals: 2) {
            let discount = Discount(mixAndMatchPromo: mixAndMatchPromo, promoItem: promoItem, amountOff: amountOff)
            discounts.append(discount)
        }
    }

    public func setBestDiscount() {
        bestDiscount = discounts.first // not really - just a stub
    }
}
