//
//  MobileOrderTotal.swift
//  MobileBench
//
//  Created by Michael Rutherford on 9/12/20.
//

import Foundation
import MoneyAndExchangeRates

public struct MobileOrderTotal {
    public var totalFrontlinePrice: MoneyWithoutCurrency = .zero
    public var totalDiscount: MoneyWithoutCurrency = .zero
    public var totalDeposit: MoneyWithoutCurrency = .zero

    public var totalDue: MoneyWithoutCurrency {
        totalFrontlinePrice - totalDiscount + totalDeposit
    }

    init(_ lines: [MobileOrderLineTotal]) {
        for line in lines {
            totalFrontlinePrice += line.totalFrontlinePrice
            totalDiscount += line.totalDiscount
            totalDeposit += line.totalDeposit
        }
    }
}
