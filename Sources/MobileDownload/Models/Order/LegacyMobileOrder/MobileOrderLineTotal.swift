//
//  MobileOrderLineTotal.swift
//  MobileBench
//
//  Created by Michael Rutherford on 9/12/20.
//

import Foundation
import MoneyAndExchangeRates

public struct MobileOrderLineTotal {
    public var qtyOrdered: Int
    public var qtyShipped: Int
    public var qtyDiscounted: Int
    
    public var totalFrontlinePrice: MoneyWithoutCurrency
    public var totalDiscount: MoneyWithoutCurrency
    public var totalDeposit: MoneyWithoutCurrency
    
    init(_ line: MobileOrderLine) {
        if line.isDiscountOnly {
            qtyOrdered = 0
            qtyShipped = 0
            qtyDiscounted = line.qtyDiscounted
            totalDiscount = qtyDiscounted * line.unitDisc
            totalFrontlinePrice = .zero
            totalDeposit = .zero
            return
        }
        
        qtyOrdered = line.qtyOrdered
        qtyShipped = line.qtyShipped
        qtyDiscounted = 0
        
        qtyDiscounted = qtyShipped
        totalDiscount = qtyShipped * line.unitDisc
        
        totalFrontlinePrice = qtyShipped * line.unitPrice
        
        totalDeposit = qtyShipped * line.unitDeposit
    }
}
