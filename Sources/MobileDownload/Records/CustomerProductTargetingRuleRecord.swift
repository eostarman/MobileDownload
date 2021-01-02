import Foundation

public final class CustomerProductTargetingRuleRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var description: String = ""
    public var fromDate: Date?
    public var thruDate: Date?
    public var targetProducts: Set<Int> = []
    public var targetCustomers: Set<Int> = []
    public var ignoreDidBuy: Bool = false
    public var ignorePresellProductSet: Bool = false
    public var requiresOnlyOneSale: Bool = false

    public init() {}
}
