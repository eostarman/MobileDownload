import Foundation

public final class ObjectiveRecord: Record, Identifiable, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var enteredByEmpNid: Int = 0
    public var entryTime: Date = Date()
    public var dueByDate: Date = Date()
    public var doneTime: Date?
    public var doneSuccess: Bool?
    public var doneComment: String?
    public var cusNid: Int = 0
    public var supNid: Int?
    public var objectiveTypeNid: Int?
    public var hostWhseNid: Int = 0
    public var empNid: Int = 0
    public var description: String = ""
    public var supplierRecName: String = ""
    public var enteredByRecName: String = ""
    public var tempNid: Int?
    public var startDate: Date?
    public var pkgNid: Int?
    public var brandNid: Int?
    public var itemNid: Int?

    public init() {}
}
