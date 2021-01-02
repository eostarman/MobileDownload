//
//  ArInfoRecord.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 12/23/20.
//

import Foundation
import MoneyAndExchangeRates

/// This is customer A/R (receivables) information
/// If the amount is (-) then we owe the customer (this is a credit); if it's (+) then this is a charge to the customer (when they purchase something)
/// Note that the original amount could be (-) but the balance could end-up being (+) - this seems common with the Coke Bottlers in North America

public class ArInfoRecord {
    public init() { }
    
    public var cusNid: Int = 0
    public var recvDate: Date = .distantFuture
    public var billToNid: Int = 0

    public var originalAmount: Money = .zeroUSD
    public var totalOwed: Money = .zeroUSD
    public var pastDueAmount: Money = .zeroUSD
    public var openCredit: Money = .zeroUSD
    public var dueByDate: Date?
    public var fullDescription: String = ""
    public var receivablesNote: String = ""

    public var companyNid: Int = 0
    public var transactionCurrencyNid: Currency = .USD
    public var accountingCurrencyNid: Currency = .USD

    public var ticketNumber: Int = 0
    public var isCusPayment: Bool = false
    public var isCusCharge: Bool = false
    public var isOrder: Bool = false
    public var isManualAddition: Bool = false
    public var isEscrow: Bool = false
    public var isPOA: Bool = false

    public var paymentTermsNid: Int?

    // these properties are used in eoTouch
    public var earlyPayDiscountAmtPossible_IfFromAnOrderObject: Money?
    public var isInOpenMobileUpload: Bool = false
    public var isInClosedOrFinalizedMobileUpload: Bool = false

    public var orderNumber: Int? { isOrder ? ticketNumber : nil }
    public var cusPaymentNid: Int? { isCusPayment ? ticketNumber : nil }
    public var cusChargeNid: Int? { isCusCharge ? ticketNumber : nil }

    public var balance: Money { totalOwed - openCredit }

    public var age: Int? // { (int)DateTime.Today.Subtract(RecvDate).TotalDays
    public var isLate: Bool = false // ((DateTime.Compare(DueByDate, DateTime.Today.Date) < 0) && (TotalOwed > 0m))

    public var isCharge: Bool {
        totalOwed.isPositive && openCredit.isZero
    }

    public var isCredit: Bool {
        totalOwed.isZero && openCredit.isPositive
    }

    public var description: String {
        let type: String
        if isOrder {
            type = "Order"
        } else if isCusCharge {
            type = "Charge"
        } else if isCusPayment {
            type = "Payment"
        } else {
            type = "Transaction"
        }

        let amount = totalOwed.isPositive ? totalOwed : openCredit

        let text = "\(type) \(ticketNumber): \(amount)"
        return text
    }
}
