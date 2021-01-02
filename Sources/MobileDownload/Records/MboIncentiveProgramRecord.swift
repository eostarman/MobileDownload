public final class MboIncentiveProgramRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""
    // not supported any more

    public init() {}
}
