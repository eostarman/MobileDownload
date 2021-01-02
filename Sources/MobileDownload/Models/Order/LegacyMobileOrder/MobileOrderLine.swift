//
//  MobileOrderLine.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/31/20.
//

import Foundation

/// A single line on an order (legacy) used while extracting the orders downloaded for delivery by a driver
public class MobileOrderLine: Identifiable, Codable {
    public var id = UUID()

    public init() { }

    public var itemNid: Int?
    public var itemWriteoffNid: Int?
    public var qtyShippedWhenVoided: Int?
    public var qtyShipped: Int?
    public var qtyOrdered: Int?

    public var qtyDiscounted: Int?
    public var promo1Nid: Int?
    public var unitDisc: Decimal?

    public var qtyLayerRoundingAdjustment: Int?
    public var crvContainerTypeNid: Int?
    public var qtyDeliveryDriverAdjustment: Int?
    public var itemNameOverride: String?
    public var unitPrice: Decimal?
    public var isManualPrice: Bool?
    public var unitSplitCaseCharge: Decimal?
    public var unitDeposit: Decimal?
    public var isManualDiscount: Bool?
    public var carrierDeposit: Decimal?
    public var bagCredit: Decimal?
    public var statePickupCredit: Decimal?
    public var unitFreight: Decimal?
    public var unitDeliveryCharge: Decimal?
    public var qtyBackordered: Int?
    public var qtyDiscountedOnThisLine: Int?
    public var isCloseDatedInMarket: Bool?
    public var isManualDeposit: Bool?
    public var basePricesAndPromosOnQtyOrdered: Bool?
    public var wasAutoCut: Bool?
    public var mergeSequenceTag: Int?
    public var autoFreeGoodsLine: Bool?
    public var isPreferredFreeGoodLine: Bool?
    public var originalQtyShipped: Int?
    public var originalItemWriteoffNid: Int?
    public var uniqueifier: Int?
    public var wasDownloaded: Bool?
    public var retailPrice: Decimal?
    public var editedRetailPrice: Bool?
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
    public var CMAOnAmt: Decimal??
    public var CTMOnAmt: Decimal?
    public var CCFOnAmt: Decimal?
    public var CMAOffAmt: Decimal?
    public var CTMOffAmt: Decimal?
    public var CCFOffAmt: Decimal?
    public var commOverrideSlsEmpNid: Int?
    public var commOverrideDrvEmpNid: Int?
    public var qtyCloseDateRequested: Int?
    public var qtyCloseDateShipped: Int?
    public var preservePricing: Bool?
    public var noteLink: Int?
    public var unitCRV: Decimal?
    public var seq: Int?
}

extension MobileOrderLine {
    public var isDiscountOnly: Bool {
        unitDisc != 0 && unitPrice == 0
    }
}
