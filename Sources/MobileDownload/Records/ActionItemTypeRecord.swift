public final class ActionItemTypeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var requiresDescription: Bool = false
    public var requiresPOS: Bool = false
    public var requiresContact: Bool = false
    public var requiresDate: Bool = false

    public init() {}
}
