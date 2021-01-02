import Foundation
import MoneyAndExchangeRates

// this is a sale to a customer of a particular item (it's downloaded as part of the customer record)
// see MobileDatabase/Download/CusItemSale.cs
// note the absence of the currency - this should be captured and downloaded in case the customer buys in different currencies.
public class CusItemSale: Identifiable, Codable {
    public var id: Int = 0

    public var additionalFeeIgnoreHistory: Bool = false
    public var cusNid: Int = 0
    public var itemNid: Int = 0
    public var orderNumber: Int = 0
    public var orderedDate: Date = .distantPast
    public var deliveryDate: Date? = nil
    public var isDelivered: Bool = false
    public var qtyOrdered: Int = 0
    public var qtyShipped: Int = 0
    public var unitPrice: MoneyWithoutCurrency = .zero
    public var unitDisc: MoneyWithoutCurrency = .zero
    public var unitDeposit: MoneyWithoutCurrency = .zero
    public var cmaOnAmt: MoneyWithoutCurrency = .zero
    public var ctmOnAmt: MoneyWithoutCurrency = .zero
    public var ccfOnAmt: MoneyWithoutCurrency = .zero
    public var cmaOffAmt: MoneyWithoutCurrency = .zero
    public var ctmOffAmt: MoneyWithoutCurrency = .zero
    public var ccfOffAmt: MoneyWithoutCurrency = .zero
    public var seq: Int = 0
    public var autoFreeGoodsLine: Bool = false

    public init() { }

    public var isDepositOnly: Bool { unitPrice.isZero && unitDiscPlusCMADotDotDot.isZero && unitDeposit.isNonZero }
    public var totalDeposit: MoneyWithoutCurrency { qtyShipped * unitDeposit }

    public var unitDiscPlusCMADotDotDot: MoneyWithoutCurrency { unitDisc + cmaOnAmt + ctmOnAmt + ccfOnAmt }
    public var isDiscountOnly: Bool { unitPrice.isZero && unitDisc.isNonZero }
    public var isFreeGoods: Bool { unitPrice == unitDiscPlusCMADotDotDot }
    public var unitNetPrice: MoneyWithoutCurrency { unitPrice - unitDiscPlusCMADotDotDot }
    public var totalPrice: MoneyWithoutCurrency { qtyShipped * unitPrice }
    public var totalDiscount: MoneyWithoutCurrency { qtyShipped * unitDiscPlusCMADotDotDot }
    public var totalNet: MoneyWithoutCurrency { totalPrice - totalDiscount }
    public var qtyAdded: Int { qtyOrdered >= 0 && qtyShipped > qtyOrdered ? qtyShipped - qtyOrdered : 0 }
    public var qtyCut: Int { qtyOrdered > 0 && qtyShipped < qtyOrdered ? qtyOrdered - qtyShipped : 0 } // mpr: only count as a cut if you didn't deliver everything that was ordered
}
