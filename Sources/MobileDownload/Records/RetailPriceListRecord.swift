import MoneyAndExchangeRates

public final class RetailPriceListRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var retailPrices: [Int: MoneyWithoutCurrency] = [:]

    public init() {}
}
