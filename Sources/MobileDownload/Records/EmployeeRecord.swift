public final class EmployeeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var overShortPassword: String = ""
    public var truckAdjustPassword: String = ""
    public var accessPassword: String = ""
    public var orderPricePassword: String = ""
    public var orderDiscPassword: String = ""
    public var whseNid: Int = 0
    public var trkNid: Int?
    public var distributorRecKey: String = ""
    public var deliveriesUseTruckInventory: Bool = false
    public var depositPassword: String = ""
    public var billingCodePricePassword: String = ""
    public var forcePromoPassword: String = ""
    public var posProductSetNid: Int?
    public var uxSurveyNids: String = ""
    public var WorkPhoneNumber: String = ""
    public var InMarketPermission: eInMarketPermissionTypes = .MayNotEnterInMarketOrders
    public var InMarketInventory: String = ""
    public var IsKegRoute: Bool = false
    public var IsRestrictedToAssignedWarehouse: Bool = false
    public var Email: String = ""
    public var PhoneNumber: String = ""

    public var presellerFlag: Bool = false
    public var driverFlag: Bool = false
    public var commonCarrierFlag: Bool = false
    public var isDistributorEmployee: Bool = false
    public var mayChangePaymentTermsOnOrders: Bool = false
    public var mayChangeProductDescriptionsOnOrders: Bool = false
    public var requireHandheldServiceFlag: Bool = false
    public var maySeeCosts: Bool = false
    public var deliveryChargePlugin_OverrideCharges: Bool = false
    public var mayVoidOrders: Bool = false
    public var mayUpdateLiquorLicense: Bool = false
    public var mayClearLineItemDeliveryAndFreightCharges: Bool = false
    public var mayEditRetailPricesOnMobileDevices: Bool = false
    public var whseManagerFlag: Bool = false
    public var mayAddBarcodes: Bool = false
    public var mayEnterProductWriteoffs: Bool = false
    public var mayEnterInventory: Bool = false
    public var mayProcessPurchasesWaitingForReceive: Bool = false
    public var mayProcessProductXfersWaitingForVerification: Bool = false
    public var mayProcessProductXfersWaitingForConfirmation: Bool = false
    public var mayProcessOrdersWaitingForPicklist: Bool = false
    public var mayApplyCredits: Bool = false
    public var mayScheduleSpecialDeliveriesOnMobileDevices: Bool = false
    public var qualifiedPromos_MayQualify: Bool = false
    public var qualifiedPromos_MayDisqualify: Bool = false
    public var mayChangePostedItemTransfers: Bool = false
    public var ordersToLoads_MayEditTransferAfterProcessing: Bool = false
    public var mayChangePostedPurchases: Bool = false
    public var bSamplesPlugin_CanRequest: Bool = false
    public var bPOSPlugin_DisallowPOSRequests: Bool = false
    public var bPOSPlugin_DisallowPOSPlacements: Bool = false
    public var bPOSPlugin_DisallowPOSPickups: Bool = false
    public var bPOSPlugin_DisallowPOSRemovals: Bool = false
    public var bPOSPlugin_DisallowPOSSurveys: Bool = false
    public var bMaySetPromoDateOnOrders: Bool = false
    public var mayPushOffDeliveries: Bool = false
    public var bMayScoreUxSurveyResults: Bool = false
    public var mayEnterProductRepacks: Bool = false
    public var maySetTaxableOnMobileDevices: Bool = false
    public var supervisorFlag: Bool = false
    public var mayEnterOffInvoicePaymentsOnMobileDevices: Bool = false
    public var requireDeliveryHandlingFlag: Bool = false
    public var MayViewFuturePromotions: Bool = false
    public var MayEditCustomerContactsOnMobileDevices: Bool = false
    public var andrewsPlugin_CreateNewTradeReturn: Bool = false

    public init() {}
}

extension EmployeeRecord {
    public enum eInMarketPermissionTypes: Int, Codable {
        case MayNotEnterInMarketOrders = 0
        case MayEnterInMarketOrders = 1
        case MayEnterInMarketOrdersWithPriceOverride = 2
    }
}
