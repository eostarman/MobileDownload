
public final class HoldCodeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var noSellFlag: Bool = false
    public var mustPayFlag: Bool = false

    public init() {}
}
