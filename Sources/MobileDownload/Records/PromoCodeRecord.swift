import MoneyAndExchangeRates

public final class PromoCodeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""

    public var recName: String = ""
    public var promoCustomers: Set<Int> = []
    public var note: String = ""
    public var isBuyXGetYFree: Bool = false
    public var isQualifiedPromo: Bool = false
    public var conditionDescription: String = ""
    public var isContractPromo: Bool = false
    public var triggerBasis: Int = 0
    public var additionalFeePromo_IgnoreHistoryForReturns: Bool = false
    public var includeInCalculationsOfSalesTax: Bool = false
    public var currency: Currency = .USD
    public var promoTierSeq: Int = 0
    public var isTieredPromo: Bool = false

    func isCustomerSelected(cusNid: Int) -> Bool {
        promoCustomers.contains(cusNid)
    }

    public init() {}
}
