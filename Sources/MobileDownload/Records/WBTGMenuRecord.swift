public final class WBTGMenuRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var cusNid: Int = 0

    public init() {}
}
