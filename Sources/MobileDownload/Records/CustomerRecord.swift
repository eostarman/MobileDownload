import Foundation
import MoneyAndExchangeRates

public final class CustomerRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var activeFlag: Bool { true }

    public var salesChannelNid: Int?
    public var geographicAreaNid: Int?
    public var chainNid: Int?
    public var taxAreaNid: Int?
    public var pricingParentNid: Int = 0
    public var whseNid: Int = 1
    public var holdCodeNid: Int?
    public var PaymentTermsNid: Int?
    public var shipAdr1: String = ""
    public var shipAdr2: String = ""
    public var shipAdr3: String = ""
    public var specialPrices: [SpecialPrice]?

    /// This is the encoded version of the customer sales transmitted from eoStar (as part of MobileDownload)
    public var encodedCusItemSales: String?
    /// This is the history of item-level sales for the customer
    public var cusItemSales: [CusItemSale]?

    public var driverNid: Int?
    public var offInvoiceDiscPct: Int = 0
    public var monthlySalesBlob: String = ""
    public var standingOrderBlob: String = ""
    public var hasCreditLimit: Bool = false
    public var creditLimit: MoneyWithoutCurrency?
    public var availableCredit: MoneyWithoutCurrency?
    public var pastDueAmount: MoneyWithoutCurrency?
    public var lastPaymentDate: Date?
    public var totalFreight: MoneyWithoutCurrency?
    public var hours: String = ""
    public var orderNote: String = ""
    public var standingPONum: String = ""
    public var storeNum: String = ""
    public var isPresell: Bool = false
    public var isTelsell: Bool = false
    public var isOffTruck: Bool = false
    public var isCustomerCallsUs: Bool = false
    public var slsEmpNids: [Int] = []
    public var numberOfAuthorizationListNids: Int = 0
    public var authorizedItemListNids: [Int] = []
    public var shelfSequenceNid: Int?
    public var buildToLevelsBlob: String = ""
    public var monthlySalesByItemBlob: String = ""
    public var liquorLicenseNumber: String = ""
    public var liquorLicenseExpirationDate: Date?
    public var numberOfCustomerVisits: Int = 0
    public var visitTime: [Date] = []
    public var visitNonServiceReasonRecName: [String] = []
    public var visitByEmployeeRecName: [String] = []
    public var visitByDescription: [String] = []
    public var buildToCountsBlob: String = ""
    public var cusDeliveryInstruction: String = ""
    public var routeBookCounts: String = ""
    public var arBalance: MoneyWithoutCurrency?
    public var cusEvents: [CusEvent] = []
    public var deliveryChargeNid: Int?
    public var brandFamilyAssignments: Set<Int> = []
    public var defaultOffDayDeliveryDriverNid: Int?
    public var idorTaxableSales: Int = 0
    public var bumpNote: String = ""
    public var shipCity: String = ""
    public var shipState: String = ""
    public var shipZip: String = ""
    public var totalDeliveryCharge: MoneyWithoutCurrency?
    public var doNotChargeUnitDeliveryCharge: Bool = false
    public var doNotChargeUnitFreight: Bool = false
    public var retailPrices: [CustomerRetailPrice] = []
    public var retailPricesAreReadOnly: Bool = false
    public var cusPermits: [CusPermit] = []
    public var specialPaymentTerms: String = ""
    public var qualifiedPromos: String = ""
    public var retailPriceListNid: Int?
    public var priceRuleNids: [Int] = []
    public var shipLatitude: Double?
    public var shipLongitude: Double?
    public var retailDateCodesBlob: String = ""
    public var iDORtaxableSalesPrev: Int = 0
    public var territoryNid: Int?
    public var ediPartnerNid: Int?
    public var uxSurveyNids: String = ""
    public var posScheduledRemovals: String = ""
    public var dexCommID: String = ""
    public var dunsPlusFour: String = ""
    public var locationNum: String = ""
    public var blacklistedItems: Set<Int> = []
    public var hasStrictCreditLimitEnforcement: Bool = false
    public var pendingOrderCreditBalance: MoneyWithoutCurrency?
    public var liquorLicenseTo: String = ""
    public var retailerInfo: RetailerInfo = RetailerInfo()
    public var useSecondaryContainerDeposits: Bool = false
    public var countHistoryBlob: String = ""
    public var vendorID: String = ""
    public var syrupTaxID: String = ""
    public var poaBalance: MoneyWithoutCurrency?
    public var poaAmount: MoneyWithoutCurrency?
    public var numberOfSalesHistoryDays: Int = 0
    public var deliveryChargePaymentTermNid: Int?
    public var sinTaxSpecialHandling: Int = 0
    public var eligibleForAutoCOD: Bool = false
    public var deliveryWindow1Start: String = ""
    public var deliveryWindow1End: String = ""
    public var deliveryWindow2Start: String = ""
    public var deliveryWindow2End: String = ""
    public var bulkPalletSizeNid: Int?
    public var countyNid: Int?
    public var holdCodeNid2: Int?
    public var isNonRetail: Bool = false
    public var stopEquipNidsBlob: String = ""
    public var billingCodeHistoryBlob: String = ""
    public var stateSalesTaxExemptCertNum: String = ""
    public var stateSalesTaxExemptCertExpirationDate: Date?
    public var countySalesTaxExemptCertNum: String = ""
    public var countySalesTaxExemptCertExpirationDate: Date?
    public var citySalesTaxExemptCertNum: String = ""
    public var citySalesTaxExemptCertExpirationDate: Date?
    public var localSalesTaxExemptCertNum: String = ""
    public var localSalesTaxExemptCertExpirationDate: Date?
    public var wholesaleSalesTaxExemptCertNum: String = ""
    public var wholesaleSalesTaxExemptCertExpirationDate: Date?
    public var openTimeRaw: String = ""
    public var closeTimeRaw: String = ""
    public var crossStreets: String = ""
    public var isClosed: Bool = false
    public var scheduleStatusNote: String = ""
    public var deliveryWindowsOverrideBlob: String = ""
    public var mobilePresellCutoffTimeOverride: Date?
    public var scheduleActiveStatus: Int = 0
    public var scheduleActiveFromDate: Date?
    public var scheduleActiveThruDate: Date?
    public var transactionCurrencyNid: Int?
    public var standingPONumbers: String = ""

    public var isTaxable: Bool = false
    public var isDistributor: Bool = false
    public var requiresPONumber: Bool = false
    public var doSerializedInventoryCountFlag: Bool = false
    public var noPreloadOfHHInvoicesFromHistoryFlag: Bool = false
    public var formatChar: String = " "
    public var doNotChargeDeposits: Bool = false
    public var printBarcodesOnHHInvoicesFlag: Bool = false
    public var printUpcInsteadOfRecKeyOnHHFlag: Bool = false
    public var isWholesaler: Bool = false
    public var isPartitionedOnPaymentTerms: Bool = false
    public var productClassBit1: Bool = false
    public var productClassBit2: Bool = false
    public var productClassBit3: Bool = false
    public var productClassBit4: Bool = false
    public var productClassBit5: Bool = false
    public var isBulkOrderFlag: Bool = false
    public var forceUseOfBuildTo: Bool = false
    public var mayBuyStrongBeer: Bool = false
    public var idor: Bool = false
    public var isFiveDigitEmpNids: Bool = false
    public var isOffPremise: Bool = false
    public var isOffScheduleCustomer: Bool = false
    public var pONumberIsRecordedByDriver: Bool = false
    public var customerBuysAlcohol: Bool = false
    public var doNotChargeDunnageDeposits: Bool = false
    public var isDEXCustomer: Bool = false
    public var returnsOnSeparateInvoice: Bool = false
    public var doNotChargeCarrierDeposits: Bool = false
    public var chargeOnlySupplierDeposits: Bool = false
    public var mayBuyWine: Bool = false
    public var doNotAllowCODOverride: Bool = false
    public var isCoop: Bool = false
    public var productClassBit6: Bool = false
    public var productClassBit7: Bool = false
    public var productClassBit8: Bool = false
    public var productClassBit9: Bool = false
    public var productClassBit10: Bool = false
    public var isProspect: Bool = false
    public var hasDraftBeer: Bool = false
    public var rollAdditionalFeesIntoPrice: Bool = false
    public var printPalletInfoOnInvoice: Bool = false
    public var hasExpirationGracePeriod: Bool = false
    public var isEligibleForTapSurveys: Bool = false
    public var returnsPartitionerIgnoresBillingCodes: Bool = false
    public var hasCustomerInvoiceFormatOverride: Bool = false
    public var mayReceiveCloseDateProduct: Bool = false
    public var hhInvoicesIgnoreItemSequence: Bool = false
    public var doNotOptimizePallets: Bool = false
    public var exemptFromCRVCharges: Bool = false

    public init() {}
}

extension CustomerRecord {
    public var transactionCurrency: Currency { Currency(currencyNid: transactionCurrencyNid) ?? .USD }

    public func getCustomerNameAndAddress() -> String {
        let address: String
        let recName = self.recName
        let street = shipAdr2

        // for large chains, a lot of times the user puts the city into the recName
        let city = recName.localizedCaseInsensitiveContains(shipCity) ? "" : shipCity

        if !street.isEmpty, !city.isEmpty {
            address = "\(street), \(city)"
        } else if !street.isEmpty {
            address = street
        } else if !city.isEmpty {
            address = city
        } else {
            address = "No address on file"
        }

        let nameAndAddress = "\(recName)\n\(address)"
        return nameAndAddress
    }
}
