public final class ChainRecord: Record, Codable { // aka FamilyMajorAccount
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""

    public var recName: String = ""
    public var blacklistedItems: Set<Int> = []
    public var requiresKnownShortageReport: Bool = false

    public init() {}
}
