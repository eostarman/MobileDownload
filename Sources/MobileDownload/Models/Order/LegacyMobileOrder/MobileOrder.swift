//
//  MobileOrder.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/31/20.
//

import Foundation
import MoneyAndExchangeRates

// the "legacy" MobileOrder transmitted from eoStar (as a "delivery to be delivered")
public class MobileOrder: Identifiable, Codable {
    public var id: Int { orderNumber }

    public init() { }

    public var companyNid: Int = 1
    public var orderNumber: Int = 0
    public var whseNid: Int = 0
    public var trkNid: Int?
    public var toCusNid: Int = 0

    public var isFromDistributor: Bool = false
    public var isToDistributor: Bool = false
    public var deliveryChargeNid: Int?
    public var isAutoDeliveryCharge: Bool = true
    public var isEarlyPay: Bool = false
    public var earlyPayDiscountAmt: MoneyWithoutCurrency = .zero
    public var termDiscountDays: Int?
    public var termDiscountPct: Int?
    public var heldStatus: Bool = false
    public var isVoided: Bool = false
    public var deliveredStatus: Bool = false
    public var orderType: eOrderType?
    public var isNewOrder: Bool = false
    public var isHotShot: Bool = false
    public var numberSummarized: Int?
    public var summaryOrderNumber: Int?
    public var coopTicketNumber: Int?
    public var shipAdr1: String?
    public var shipAdr2: String?
    public var shipCity: String?
    public var shipState: String?
    public var shipZip: String?
    public var doNotChargeUnitFreight: Bool = false
    public var doNotChargeUnitDeliveryCharge: Bool = false
    public var ignoreDeliveryTruckRestrictions: Bool = false
    public var signatureVectors: String?
    public var driverSignatureVectors: String?
    public var isOffScheduleDelivery: Bool = false
    public var isSpecialPaymentTerms: Bool = false
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
    public var isVendingReplenishment: Bool = false
    public var replenishmentVendTicketNumber: Int?
    public var isCoopDeliveryPoint: Bool = false
    public var coopCusNid: Int?
    public var doNotOptimizePalletsWithLayerRounding: Bool = false
    public var returnsValidated: Bool = false
    public var POAAmount: MoneyWithoutCurrency = .zero
    public var POAExpected: MoneyWithoutCurrency = .zero
    public var includeChargeOrderInTotalDue: Bool = false
    public var deliverySequence: Int?
    public var orderDEXStatus: eOrderDEXStatus?
    public var isForPlanogramReset: Bool = false
    public var manualHold: Bool = false
    public var pushOffDate: Date?
    public var drvEmpNid: Int?
    public var slsEmpNid: Int?
    public var orderTypeNid: Int?
    public var isBillAndHold: Bool = false
    public var paymentTermsNid: Int?
    public var isBulkOrder: Bool = false
    public var isCharge: Bool = false
    public var isTaxable: Bool = false
    public var usedCombinedForm: Bool = false
    public var isEft: Bool = false
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
    public var discountAmt: MoneyWithoutCurrency = .zero
    public var totalFreight: MoneyWithoutCurrency = .zero
    public var isExistingOrder: Bool = false
    public var printedReviewInvoice: Bool = false
    public var voidReasonNid: Int?
    public var isPresell: Bool = false
    public var entryTime: Date?
    public var deliveredByHandheld: Bool = false
    public var isOffTruck: Bool = false
    public var isFromBlobbing: Bool = false
    public var orderNumbersForPartitioner: [Int] = []
    public var deliveryInfos: [DeliveryInfoForPartitioning] = []

    public var salesTax: MoneyWithoutCurrency = .zero
    public var salesTaxState: MoneyWithoutCurrency = .zero
    public var salesTaxStateB: MoneyWithoutCurrency = .zero
    public var salesTaxStateC: MoneyWithoutCurrency = .zero
    public var salesTaxCounty: MoneyWithoutCurrency = .zero
    public var salesTaxCity: MoneyWithoutCurrency = .zero
    public var salesTaxLocal: MoneyWithoutCurrency = .zero
    public var salesTaxWholesale: MoneyWithoutCurrency = .zero
    public var VAT: MoneyWithoutCurrency = .zero
    public var levy: MoneyWithoutCurrency = .zero

    public var lines: [MobileOrderLine] = []
}
