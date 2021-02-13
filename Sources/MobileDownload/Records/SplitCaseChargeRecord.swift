import Foundation
import MoneyAndExchangeRates

public final class SplitCaseChargeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var amount: MoneyWithoutCurrency = .zero
    public var productSetNid: Int?                          // may be (nil)
    public var isPerAltPackCharge: Bool = false
    public var cutoffPrice: MoneyWithoutCurrency?
    public var effectiveDate: Date?

    public init() {}
}
