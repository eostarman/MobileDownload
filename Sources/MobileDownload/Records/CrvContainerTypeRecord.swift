import MoneyAndExchangeRates

public final class CrvContainerTypeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var taxRate: MoneyWithoutCurrency?

    public init() {}
}
