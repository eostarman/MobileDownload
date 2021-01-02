public final class EquipmentModelRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var infoURL: String = ""
    public var imageValueAsHexString: String = ""
    public var vendFillsAreInCases: Bool = false
    public var vendFillsAreByCount: Bool = false

    public init() {}
}
