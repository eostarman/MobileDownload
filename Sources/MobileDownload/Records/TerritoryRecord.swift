public final class TerritoryRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var brandFamilyAssignments: Set<Int> = []

    public init() {}
}
