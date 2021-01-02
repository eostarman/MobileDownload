import MoneyAndExchangeRates

public final class DeliveryChargeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var chargeIsBasedOnQty: Bool = false
    public var isFlatCharge: Bool = false
    public var chargeAmount: MoneyWithoutCurrency = .zero
    public var threshold: MoneyWithoutCurrency = .zero
    public var applyChargeToFreeGoods: Bool = false

    public init() {}
}
