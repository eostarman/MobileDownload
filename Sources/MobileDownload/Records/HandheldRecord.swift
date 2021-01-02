import Foundation
import MoneyAndExchangeRates

public final class HandheldRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var handheldEmpNid: Int = 0
    public var routeWhseNid: Int = 0
    public var nbrPriceDecimals: Int = 0
    public var trkNid: Int?
    public var fromYear: Int = 0
    public var thruYear: Int = 0
    public var availableOrderNumbers: [Int] = []
    public var availableItemTransferNumbers: [Int] = []
    public var invoiceHeader: String?
    public var advertisement: String?

    public var driverPreorder: String = ""
    public var maxTransactionDaysOut: Int = 0
    public var defaultOffDayDeliveryDriverNid: Int?
    public var invoiceLogoNid: Int?
    public var nonReturnablesProductSetNid: Int?
    public var nonReturnablesOverridePassword: String = ""
    public var rutherfordDatabaseNumber: String = ""
    public var nonReturnablesPresellProductSetNid: Int?
    public var nonReturnablesPresellOverridePassword: String = ""
    public var posRemovalsOrderTypeNid: Int?
    public var liquorLicenseWarningDays: Int = 0
    public var storeLevelDatecodeThresholdInDays: Int = 0
    public var presellProductSetNid: Int?
    public var vendProductSetNid: Int?
    public var whseDuns: String = ""
    public var dexCommID: String = ""
    public var locationNum: String = ""
    public var sigKey: Int = 0
    public var reportsToEmpNids: [Int] = [] // the employees who report-to the actualEmpNid
    public var actualEmpNid: Int = 0
    public var routeEmpNid: Int = 0
    public var syncSessionNid: Int?
    public var rawSyncTimestampWithoutTimezone: String = ""
    public var otlDeliveryAdjustmentNid: Int?
    public var webOrderTypeNid: Int?
    public var defaultPaymentCompanyNid: Int?
    public var liquorLicenseExpirationGracePeriod: Int = 0
    public var companyItems: [CompanyItem] = []
    public var extendedReturnReasonCutoffDays: Int = 0
    public var dEXRemovalReason: Int = 0

    /// When pickup up dunnage (empties, kegs, skids under pallets, ...) propose a short list of the top dunnage items picked up. This is because we don't record the "delivery" of dunnage, just the pickup - leaving us with no informative history to use
    public var topDunnageItemNids: [Int] = []
    public var numberOfSalesHistoryDays: Int = 0
    public var defaultMisPickAdjustmentReasonNid: Int?
    public var softeonDeliveryAdjustmentReasonNid: Int?

    /// The bays on this truck (e.g. "D1" for driver-side 1st bay; "P1" for passenger-side bay that's closest to the cab (the bays at the rear of the trailer are higher numbered bays)
    public var truckBays: [String] = []

    public var autoCODPaymentTermsEnabled: Bool = false
    public var autoCODPaymentTermsNid: Int?
    public var autoCODPastDueDays: Int = 0
    public var autoCODMinPastDue: MoneyWithoutCurrency?
    public var autoCutDuringOrderEntry: Bool = false

    /// The version of the app (eoTouch) that requested this MobileDownload
    public var appVersion: String = ""

    /// The version of the web service (eonetservice) that produced the MobileDownload
    public var eoNetServiceVersion: String = ""

    /// The version of the SQL database that sourced the data
    public var databaseVersion: String = ""

    public var autoCutExclusionProductSetNid: Int?
    public var walkaroundCountCutoffDate: Date?
    public var directSwapOrderTypeNid: Int?
    public var autoIncludeCreditsInDeliverStop: Bool = false
    public var autoIncludeCreditsCustomerSetNid: Int?
    public var autoIncludeCreditsMaxAmount: MoneyWithoutCurrency?
    public var autoIncludePastDueARFromDeliverStop: Bool = false
    public var autoIncludePastDueARCustomerSetNid: Int?
    public var inMarketOrderTypeNid: Int?
    public var customerWebLoginNid: Int?
    public var explicitCusNidsForCustomerWeb: [Int] = [] // used in CustomerWeb to list the customers assigned to the web login
    public var customerWebEmail: String = ""
    public var customerWebPassword: String = ""
    public var rawSyncTimestampWithTimezone: String = ""
    public var requireAuthorizationForDeliveryAdjustmentsAboveThreshold: Bool = false
    public var deliveryAdjustmentAuthorizationThreshold: Int = 0
    public var vendReturnDamagedItemWriteoffNid: Int?
    public var vendReturnOutOfDateItemWriteoffNid: Int?
    public var truckRecKeys: [String] = []
    public var noTrailerTruckRecKeys: [String] = []
    public var serviceRequirePartsField: Bool = false
    public var serviceRequireProcedureField: Bool = false
    public var serviceRequireNoteField: Bool = false
    public var serviceRequireSystemField: Bool = false
    public var serviceRequireSubsystemField: Bool = false
    public var defaultCurrencyNid: Int?
    public var exchangeRates = ExchangeRates()

    public var routeType: eRouteType = .Regular

    public var activeFlag: Bool = false
    public var isWarehouse: Bool = false
    public var isDelivery: Bool = false
    public var requiresDepositsSupport: Bool = false
    public var printTaxBreakdownOnHandheldInvoices: Bool = false
    public var printARBalanceOnHandheldInvoices: Bool = false
    public var requiresScheduleSupport: Bool = false
    public var requiresRouteBookSupport: Bool = false
    public var requiresBeerWinePluginSupport: Bool = false
    public var useQtyOrderedForPricingAndPromos: Bool = false
    public var autoSetDriverBasedOnDate: Bool = false
    public var requiresAllocationSupport: Bool = false
    public var useCombinedOrderEntryForm: Bool = false
    public var isIllinoisTaxPluginInstalled: Bool = false
    public var useItemDeliverySequence: Bool = false
    public var mtdytd_IsCaseEquiv: Bool = false
    public var supportBackorderedPurchases: Bool = false
    public var isOhioTaxPluginInstalled: Bool = false
    public var requireDateCodesWhenCountingWarehouse: Bool = false
    public var enforceRestoreCode: Bool = false
    public var mobilePresellersCanSchedulePickups: Bool = false
    public var requiresPOSSupport: Bool = false
    public var requireDriverSignature: Bool = false
    public var hH_COD_PaymentRequired: Bool = false
    public var isGoalsPluginInstalled: Bool = false
    public var downloadGoalsAtFullsync: Bool = false
    public var downloadAllDataForOffScheduleCustomers: Bool = false
    public var includeCommonCarrierShipments: Bool = false
    public var enableStoreLevelDatecodeRecording: Bool = false
    public var isCaliforniaTaxPluginInstalled: Bool = false
    public var isTruckInspectionPluginInstalled: Bool = false
    public var isUxPluginInstalled: Bool = false
    public var handheldShowDollarsForInvoiceReview: Bool = false
    public var handheldEnforceBeginOfDayTruckInsp: Bool = false
    public var isUserPeerlessPluginInstalled: Bool = false
    public var printLocationOnStripTruck: Bool = false
    public var isUserJJTaylorPluginInstalled: Bool = false
    public var useSellDaysForDeliveries: Bool = false
    public var wineBottleReatilUPC: Bool = false
    public var isObjectivesPluginInstalled: Bool = false
    public var isAllied: Bool = false
    public var requiresAdAlertSupport: Bool = false
    public var noRedBullSalesToOffPremiseAccounts: Bool = false
    public var driversSeeDeliveriesOnly: Bool = false
    public var isWineByTheGlassPluginInstalled: Bool = false
    public var requireDeliveryVoidCode: Bool = false
    public var useExtendedReturnReasonDialog: Bool = false
    public var isCoopPluginInstalled: Bool = false
    public var handheldLeftOnTruckDefault: Bool = false
    public var considerOffTruckInDeliverySchedule: Bool = false
    public var isMultiCompanyPluginInstalled: Bool = false
    public var multiCompanyByWarehouse: Bool = false
    public var uploadAfterDelivery: Bool = false
    public var isVendingPluginInstalled: Bool = false
    public var isTaxSchedulePluginInstalled: Bool = false
    public var requireTruckAndTrailerNumber: Bool = false
    public var hhPicklistsGroupByPackage: Bool = false
    public var isCokePluginInstalled: Bool = false
    public var isBackorderPluginInstalled: Bool = false
    public var promoRebatesSupercedeSupplierRebates: Bool = false
    public var purchasesAreProducedInHouse: Bool = false
    public var requireTapSurveyForOnPremiseBeerCustomers: Bool = false
    public var useDeliverStopForMultiInvoiceCustomers: Bool = false
    public var partitionOffTruckOrders: Bool = false
    public var useRestockReturnReason: Bool = false
    public var supplierCostIsNotWholesalerPrice: Bool = false
    public var isQtyVendedBasedOnFills: Bool = false
    public var neverUseHistoricalPriceForReturns: Bool = false
    public var preserveQuotedDiscountsAfterPartitioning: Bool = false
    public var printDeliveryDiscrepanciesOnHandheldInvoices: Bool = false
    public var isSyrupTaxPluginInstalled: Bool = false
    public var vendDriversNotScheduledForVendingMayEnterVendTickets: Bool = false
    public var printMergeAutoLinesOnHandheldInvoices: Bool = false
    public var isAutoBumpPluginInstalled: Bool = false
    public var isC2CPluginInstalled: Bool = false
    public var c2cTracksDistributionByDateOnly: Bool = false
    public var isActionItemsPluginInstalled: Bool = false
    public var isCloseDatePluginInstalled: Bool = false
    public var strictLiquorLicenseEnforcement: Bool = false
    public var extendedReturnReasonChooseLowestPrice: Bool = false
    public var requireDateCodesForReturns: Bool = false
    public var requireDateCodesForReturns_DriverValidationRequired: Bool = false
    public var isDateCodePluginInstalled: Bool = false
    public var forcePrCEPrinting: Bool = false
    public var sortInvoiceByPalletSeq: Bool = false
    public var mandatorySurveysCompletedAfterOrderHandling: Bool = false
    public var isAndrewsPluginInstalled: Bool = false
    public var handheldEnforceEndOfDayTruckInsp: Bool = false
    public var isNewJerseyTaxPluginInstalled: Bool = false
    public var enablePOA: Bool = false
    public var isBeverageTaxPluginInstalled: Bool = false
    public var doNotUseQtyOrderedForBuyXGetY: Bool = false
    public var groupScansheetByPackage: Bool = false
    public var uploadPresellAfterSave: Bool = false
    public var requireCheckInReturnValidation: Bool = false
    public var requireSignaturesForStripTruck: Bool = false
    public var driversMustHandleAllDeliveriesBeforeSync: Bool = false
    public var useReceivableGroups: Bool = false
    public var notesRequireDriverReview: Bool = false
    public var includeBillingCodesInTermsPartitioning: Bool = false
    public var cuyahogaSpecialHandling: Bool = false
    public var isRetailerPluginInstalled: Bool = false
    public var handheldPalletBreakdownScansheet: Bool = false
    public var netServiceSupportsPostingCustomerNoteEdits: Bool = false
    public var isMetric: Bool = false

    public var syncTime = Date()
    public var syncDate = Date()

    public init(recNid: Int, recKey: String, recName: String) {
        self.recNid = recNid
        self.recKey = recKey
        self.recName = recName
    }

    public init() {}
}

extension HandheldRecord {
    public enum eRouteType: Int, Codable {
        case Regular = 0
        case Overnight = 1
        case Day = 2
    }
}

extension HandheldRecord {
    public var isAlliance: Bool { rutherfordDatabaseNumber == "MI-1069-3034" }
}
