//
//  MobileOrder.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/31/20.
//

import Foundation

// the "legacy" MobileOrder transmitted from eoStar (as a "delivery to be delivered")
public class MobileOrder: Identifiable, Codable {
    public var id: Int { orderNumber }

    public init() { }

    public var companyNid: Int = 1
    public var orderNumber: Int = 0
    public var whseNid: Int = 0
    public var trkNid: Int?
    public var toCusNid: Int = 0

    public var isFromDistributor: Bool?
    public var isToDistributor: Bool?
    public var deliveryChargeNid: Int?
    public var isAutoDeliveryCharge: Bool?
    public var isEarlyPay: Bool?
    public var earlyPayDiscountAmt: Decimal?
    public var termDiscountDays: Int?
    public var termDiscountPct: Int?
    public var heldStatus: Bool?
    public var isVoided: Bool?
    public var deliveredStatus: Bool?
    public var orderType: eOrderType?
    public var isNewOrder: Bool?
    public var isHotShot: Bool?
    public var numberSummarized: Int?
    public var summaryOrderNumber: Int?
    public var coopTicketNumber: Int?
    public var shipAdr1: String?
    public var shipAdr2: String?
    public var shipCity: String?
    public var shipState: String?
    public var shipZip: String?
    public var doNotChargeUnitFreight: Bool?
    public var doNotChargeUnitDeliveryCharge: Bool?
    public var ignoreDeliveryTruckRestrictions: Bool?
    public var signatureVectors: String?
    public var driverSignatureVectors: String?
    public var isOffScheduleDelivery: Bool?
    public var isSpecialPaymentTerms: Bool?
    public var promoDate: Date?

    public var authenticatedByNid: Int?
    public var authenticatedDate: Date?
    public var deliveredDate: Date?
    public var deliveredByNid: Int?
    public var deliveryDocumentDate: Date?
    public var deliveryDocumentByNid: Int?
    public var dispatchedDate: Date?
    public var dispatchedByNid: Int?
    public var ediInvoiceDate: Date?
    public var ediInvoiceByNid: Int?
    public var ediPaymentDate: Date?
    public var ediPaymentByNid: Int?
    public var ediShipNoticeDate: Date?
    public var ediShipNoticeByNid: Int?
    public var enteredDate: Date?
    public var enteredByNid: Int?
    public var followupInvoiceDate: Date?
    public var followupInvoiceByNid: Int?
    public var loadedDate: Date?
    public var loadedByNid: Int?
    public var orderedDate: Date?
    public var orderedByNid: Int?
    public var palletizedDate: Date?
    public var palletizedByNid: Int?
    public var pickListDate: Date?
    public var pickListByNid: Int?
    public var shippedDate: Date?
    public var shippedByNid: Int?
    public var stagedDate: Date?
    public var stagedByNid: Int?
    public var verifiedDate: Date?
    public var verifiedByNid: Int?
    public var voidedDate: Date?
    public var voidedByNid: Int?

    public var loadNumber: Int?
    public var toEquipNid: Int?
    public var isVendingReplenishment: Bool?
    public var replenishmentVendTicketNumber: Int?
    public var isCoopDeliveryPoint: Bool?
    public var coopCusNid: Int?
    public var doNotOptimizePalletsWithLayerRounding: Bool?
    public var returnsValidated: Bool?
    public var POAAmount: Decimal?
    public var POAExpected: Decimal?
    public var includeChargeOrderInTotalDue: Bool?
    public var deliverySequence: Int?
    public var orderDEXStatus: eOrderDEXStatus?
    public var isForPlanogramReset: Bool?
    public var manualHold: Bool?
    public var pushOffDate: Date?
    public var drvEmpNid: Int?
    public var slsEmpNid: Int?
    public var orderTypeNid: Int?
    public var isBillAndHold: Bool?
    public var paymentTermsNid: Int?
    public var isBulkOrder: Bool?
    public var isCharge: Bool?
    public var isTaxable: Bool?
    public var usedCombinedForm: Bool?
    public var isEft: Bool?
    public var poNumber: String?
    public var takenFrom: String?
    public var invoiceNote: String?
    public var packNote: String?
    public var serializedItems: String?
    public var receivedBy: String?
    public var pushOffReason: String?
    public var skipReason: String?
    public var voidReason: String?
    public var offInvoiceDiscPct: Int?
    public var discountAmt: Decimal?
    public var totalFreight: Decimal?
    public var isExistingOrder: Bool?
    public var printedReviewInvoice: Bool?
    public var voidReasonNid: Int?
    public var isPresell: Bool?
    public var entryTime: Date?
    public var deliveredByHandheld: Bool?
    public var isOffTruck: Bool?
    public var isFromBlobbing: Bool?
    public var orderNumbersForPartitioner: [Int] = []
    public var deliveryInfos: [DeliveryInfoForPartitioning] = []

    public var salesTax: Decimal?
    public var salesTaxState: Decimal?
    public var salesTaxStateB: Decimal?
    public var salesTaxStateC: Decimal?
    public var salesTaxCounty: Decimal?
    public var salesTaxCity: Decimal?
    public var salesTaxLocal: Decimal?
    public var salesTaxWholesale: Decimal?
    public var VAT: Decimal?
    public var levy: Decimal?

    public var lines: [MobileOrderLine] = []
}
