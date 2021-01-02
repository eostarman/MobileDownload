import Foundation

public final class ActionItemRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var actionItemNumber: Int = 0
    public var assignedToEmpNid: Int?
    public var cusNid: Int?
    public var actionItemTypeNid: Int?
    public var description: String = ""
    public var contact: String = ""
    public var pos: String = ""
    public var actionDateRangeFrom: Date?
    public var actionDateRangeThru: Date?
    public var customer: String = ""
    public var actionItemType: String = ""
    public var actionItemState: Int = 0
    public var actionItemStateText: String = ""
    public var enteredByEmpNid: Int?
    public var entryTime: Date?

    public init() {}
}
