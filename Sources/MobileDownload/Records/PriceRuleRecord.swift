/// A price rule assigns a price book (with all of its related price sheets) to be used for sales from a warehouse.
/// It also identifies the column in the price book (i.e. in each price sheet) that should be used.
/// And, if automatic columns may be used (based on order quantities) then this is indicated

public final class PriceRuleRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var shipFromWhseNid: Int?
    public var priceBookNid: Int = 0
    public var priceLevel: Int = 0
    public var canUseAutomaticColumns: Bool = false

    public init() {}
}
