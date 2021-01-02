//
//  PromoService.swift
//  MobileBench
//
//  Created by Michael Rutherford on 7/20/20.
//

import Foundation

// this will parse, process and apply promotions for a customer on a given date
public struct PromoService {
    let cusNid: Int
    let date: Date

    var promoCodesForThisCustomer: [Int: PromoCodeRecord] = [:]

    public var mixAndMatchPromos: [MixAndMatchPromo] = []

    var unsupportedPromoSections: [PromoSectionRecord] = []

    public init(cusNid: Int, date: Date) {
        self.cusNid = cusNid
        self.date = date

        for promoCode in mobileDownload.promoCodes.getAll() {
            if promoCode.isCustomerSelected(cusNid: cusNid) {
                promoCodesForThisCustomer[promoCode.recNid] = promoCode
            }
        }

        if promoCodesForThisCustomer.isEmpty {
            return
        }

        for promoSection in mobileDownload.promoSections.getAll() {
            guard let promoCode = promoCodesForThisCustomer[promoSection.promoCodeNid] else {
                continue
            }

            if !promoSection.isActiveOnDate(date) {
                continue
            }

            if promoSection.isMixAndMatch, promoSection.promoPlan == .Default {
                let mixAndMatchPromo = MixAndMatchPromo(promoCode: promoCode, promoSection: promoSection)
                mixAndMatchPromos.append(mixAndMatchPromo)
            } else {
                unsupportedPromoSections.append(promoSection)
            }
        }
    }

    public func computeDiscounts(lines: [SaleLine]) {
        let qtys = TriggerQtys()
        for line in lines {
            line.clearDiscounts()
            qtys.addItemAndQty(itemNid: line.itemNid, qty: line.qtyOrdered)
        }

        for promo in mixAndMatchPromos {
            let isTriggered = promo.isTriggered(qtys: qtys)

            if !isTriggered {
                continue
            }

            for line in lines {
                if let promoItem = promo.getDiscount(line.itemNid) {
                    line.addDiscount(mixAndMatchPromo: promo, promoItem: promoItem)
                }
            }
        }

        for line in lines {
            line.setBestDiscount()
        }
    }
}
