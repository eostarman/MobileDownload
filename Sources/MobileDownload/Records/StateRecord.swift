import MoneyAndExchangeRates

public final class StateRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var stateTaxBDescription: String = ""
    public var salesTaxStateBBlob: String = ""
    public var stateTaxCDescription: String = ""
    public var salesTaxStateCBlob: String = ""
    public var deliveryChargeAmount: MoneyWithoutCurrency?
    public var refuseDEXPriceChanges: Bool = false
    public var alcoholCompliancePaymentTermsNid: Int?
    public var alcoholCompliancePaymentTermsApplyToAlcoholOnly: Bool = false
    public var alcoholComplianceHoldCodeNid: Int?
    public var alcoholComplianceCusNids: Set<Int> = []
    public var doesNotCreditBackSplitCaseCharges: Bool = false
    public var restrictDiscountBasedOnDeliveryDate: Bool = false
    public var restrictKegBeerDiscountDays: Int = 0
    public var restrictOtherBeerDiscountDays: Int = 0

    public init() {}
}
