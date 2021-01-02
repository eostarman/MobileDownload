public final class TIItemRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var sequence: Int = 0
    public var tiCategoryNid: Int = 0

    public init() {}
}
