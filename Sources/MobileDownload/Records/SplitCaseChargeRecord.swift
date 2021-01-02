import Foundation
import MoneyAndExchangeRates

public final class SplitCaseChargeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var amount: MoneyWithoutCurrency = .init(scaledAmount: 0, numberOfDecimals: 0)
    public var productSetNid: Int = 0
    public var isPerAltPackCharge: Bool = false
    public var cutoffPrice: MoneyWithoutCurrency?
    public var effectiveDate: Date?

    public init() {}
}
