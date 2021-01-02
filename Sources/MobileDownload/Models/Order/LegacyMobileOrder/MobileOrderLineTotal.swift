//
//  MobileOrderLineTotal.swift
//  MobileBench
//
//  Created by Michael Rutherford on 9/12/20.
//

import Foundation

public struct MobileOrderLineTotal {
    public var qtyOrdered: Int
    public var qtyShipped: Int
    public var qtyDiscounted: Int

    public var totalFrontlinePrice: Decimal?
    public var totalDiscount: Decimal?
    public var totalDeposit: Decimal?

    init(_ line: MobileOrderLine) {
        if line.isDiscountOnly {
            qtyOrdered = 0
            qtyShipped = 0
            qtyDiscounted = line.qtyDiscounted ?? 0
            if let unitDisc = line.unitDisc {
                totalDiscount = Decimal(qtyDiscounted) * unitDisc
            }
            return
        }

        qtyOrdered = line.qtyOrdered ?? 0
        self.qtyShipped = line.qtyShipped ?? 0
        qtyDiscounted = 0

        if qtyShipped == 0 {
            return
        }

        let qtyShipped = Decimal(self.qtyShipped)

        if let unitDisc = line.unitDisc {
            qtyDiscounted = self.qtyShipped
            totalDiscount = qtyShipped * unitDisc
        }

        if let unitPrice = line.unitPrice {
            totalFrontlinePrice = qtyShipped * unitPrice
        }

        if let unitDeposit = line.unitDeposit {
            totalDeposit = qtyShipped * unitDeposit
        }
    }
}
