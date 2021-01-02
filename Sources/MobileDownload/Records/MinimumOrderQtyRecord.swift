import Foundation

public final class MinimumOrderQtyRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var productSetNid: Int?
    public var minQty: Int = 0
    public var customerSetNid: Int?
    public var effectiveDate: Date = .distantPast
    public var cusNids: Set<Int> = []
    public var itemNids: Set<Int> = []
    public var Note: String = ""

    public init() {}
}
