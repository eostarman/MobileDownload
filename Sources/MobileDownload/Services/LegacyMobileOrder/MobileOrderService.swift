//
//  MobileOrderService.swift
//  MobileBench
//
//  Created by Michael Rutherford on 9/12/20.
//

import Foundation

public struct MobileOrderService {
    public let order: MobileOrder

    public init(order: MobileOrder) {
        self.order = order
    }

    public func isPaymentRequired() -> Bool {
        if let paymentTermsNid = order.paymentTermsNid {
            let paymentTerms = mobileDownload.paymentTerms[paymentTermsNid]
            return paymentTerms.cashOnlyNoChecks || paymentTerms.isCOD
        } else {
            return true
        }
    }

    public func getMobileOrderTotal() -> MobileOrderTotal {
        let total = MobileOrderTotal(order.lines.map { MobileOrderLineTotal($0) })
        return total
    }
}
