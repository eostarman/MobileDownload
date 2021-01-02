import Foundation

public final class RetailInitiativeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var fromDate: Date?
    public var thruDate: Date?
    public var description: String = ""

    public var retailInitiative = RetailInitiative()

    public var cusNids: Set<Int> = []

    public init() {}
}
