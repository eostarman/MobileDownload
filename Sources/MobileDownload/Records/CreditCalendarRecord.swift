public final class CreditCalendarRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var dueDateBlob: String = ""

    public init() {}
}
