import Foundation

public final class MessageRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var fromEmpNid: Int = 0
    public var sentDate: Date?

    public var toEmpNids: Set<Int> = []
    public var unreadEmpNids: Set<Int> = []

    public var fromEmployeeRecName: String?

    public init() {}
}
