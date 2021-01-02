//
//  MobileOrderTotal.swift
//  MobileBench
//
//  Created by Michael Rutherford on 9/12/20.
//

import Foundation

public struct MobileOrderTotal {
    public var totalFrontlinePrice: Decimal = 0
    public var totalDiscount: Decimal = 0
    public var totalDeposit: Decimal = 0

    public var totalDue: Decimal {
        totalFrontlinePrice - totalDiscount + totalDeposit
    }

    init(_ lines: [MobileOrderLineTotal]) {
        for line in lines {
            totalFrontlinePrice += line.totalFrontlinePrice ?? 0
            totalDiscount += line.totalDiscount ?? 0
            totalDeposit += line.totalDeposit ?? 0
        }
    }
}
