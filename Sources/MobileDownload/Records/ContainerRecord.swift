import MoneyAndExchangeRates

public final class ContainerRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var carrierDeposit: MoneyWithoutCurrency?
    public var bagCredit: MoneyWithoutCurrency?
    public var statePickupCredit: MoneyWithoutCurrency?
    public var carrierDeposit2: MoneyWithoutCurrency?
    public var bagCredit2: MoneyWithoutCurrency?
    public var statePickupCredit2: MoneyWithoutCurrency?
    public var containerItemNid: Int?

    public init() {}
}
