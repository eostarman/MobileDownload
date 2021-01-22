//
//  MobileOrderLine.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/31/20.
//

import Foundation
import MoneyAndExchangeRates

/// A single line on an order (legacy) used while extracting the orders downloaded for delivery by a driver
public class MobileOrderLine: Identifiable, Codable {
    public var id = UUID()

    public init() { }

    public var itemNid: Int?
    public var itemWriteoffNid: Int?
    public var qtyShippedWhenVoided: Int?
    public var qtyShipped: Int = 0
    public var qtyOrdered: Int = 0

    public var qtyDiscounted: Int = 0
    public var promo1Nid: Int?
    public var unitDisc: MoneyWithoutCurrency = .zero

    public var qtyLayerRoundingAdjustment: Int?
    public var crvContainerTypeNid: Int?
    public var qtyDeliveryDriverAdjustment: Int?
    public var itemNameOverride: String?
    public var unitPrice: MoneyWithoutCurrency = .zero
    public var isManualPrice: Bool = false
    public var unitSplitCaseCharge: MoneyWithoutCurrency = .zero
    public var unitDeposit: MoneyWithoutCurrency = .zero
    public var isManualDiscount: Bool = false
    public var carrierDeposit: MoneyWithoutCurrency = .zero
    public var bagCredit: MoneyWithoutCurrency = .zero
    public var statePickupCredit: MoneyWithoutCurrency = .zero
    public var unitFreight: MoneyWithoutCurrency = .zero
    public var unitDeliveryCharge: MoneyWithoutCurrency = .zero
    public var qtyBackordered: Int?
    public var qtyDiscountedOnThisLine: Int?
    public var isCloseDatedInMarket: Bool = false
    public var isManualDeposit: Bool = false
    public var basePricesAndPromosOnQtyOrdered: Bool = false
    public var wasAutoCut: Bool = false
    public var mergeSequenceTag: Int?
    public var autoFreeGoodsLine: Bool = false
    public var isPreferredFreeGoodLine: Bool = false
    public var originalQtyShipped: Int?
    public var originalItemWriteoffNid: Int?
    public var uniqueifier: Int?
    public var wasDownloaded: Bool = false
    public var retailPrice: MoneyWithoutCurrency?
    public var editedRetailPrice: Bool = false
    public var buildTo: Int?
    public var count: Decimal?
    public var routeBookBuildTo: Decimal?
    public var pickAndShipDateCodes: String?
    public var dateCode: Date?
    public var parentSlsEmpNid: Int?
    public var parentOrderedDate: Date?
    public var CMAOnNid: Int?
    public var CTMOnNid: Int?
    public var CCFOnNid: Int?
    public var CMAOffNid: Int?
    public var CTMOffNid: Int?
    public var CCFOffNid: Int?
    public var CMAOnAmt: MoneyWithoutCurrency = .zero
    public var CTMOnAmt: MoneyWithoutCurrency = .zero
    public var CCFOnAmt: MoneyWithoutCurrency = .zero
    public var CMAOffAmt: MoneyWithoutCurrency = .zero
    public var CTMOffAmt: MoneyWithoutCurrency = .zero
    public var CCFOffAmt: MoneyWithoutCurrency = .zero
    public var commOverrideSlsEmpNid: Int?
    public var commOverrideDrvEmpNid: Int?
    public var qtyCloseDateRequested: Int?
    public var qtyCloseDateShipped: Int?
    public var preservePricing: Bool = false
    public var noteLink: Int?
    public var unitCRV: MoneyWithoutCurrency = .zero
    public var seq: Int = 0
}

extension MobileOrderLine {
    
    /// the frontline price (unitPrice) less discounts (unitDisc) plus deposits (unitDeposit)
    public var netUnitPrice: MoneyWithoutCurrency {
        unitPrice - unitDisc + unitDeposit
    }
    
    /// If the line has no price, but it does have a discount then it's a "discount only" line - it's used for additional discounts
    public var isDiscountOnly: Bool {
        unitDisc.isNonZero && unitPrice.isZero
    }
}
