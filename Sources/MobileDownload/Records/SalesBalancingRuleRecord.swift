import Foundation

// TODO:
public final class SalesBalancingRuleRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var cusQtyLimit: Int?
    public var empQtyLimit: Int?
    public var rulePeriod: eSalesBalancingRulePeriod = .EntirePeriod
    public var fromDate: Date = .distantPast
    public var thruDate: Date = .distantFuture
    public var cusNidStr: String = ""
    public var itemNidStr: String = ""
    public var cusExceptionsString: String = ""
    public var empExceptionsString: String = ""
    public var Note: String = ""

    public init() {}
}

extension SalesBalancingRuleRecord {
    public enum eSalesBalancingRulePeriod: Int, Codable {
        case PerDay = 0
        case PerWeek = 1
        case PerMonth = 2
        case EntirePeriod = 3
    }
}
