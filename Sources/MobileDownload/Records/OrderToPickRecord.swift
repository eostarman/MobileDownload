import MobileLegacyOrder

public final class OrderToPickRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var order = LegacyOrder()

    public init() {}
}
