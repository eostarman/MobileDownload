import Foundation

public final class ObjectiveRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var enteredByEmpNid: Int = 0
    public var entryTime: String = "" // DateTime
    public var dueByDate: String = "" // DateTime
    public var doneTime: String = "" // DateTime
    public var doneSuccess: Int = 0
    public var doneComment: String = ""
    public var cusNid: Int?
    public var supNid: Int?
    public var objectiveTypeNid: Int = 0
    public var hostWhseNid: Int = 0
    public var empNid: Int = 0
    public var description: String = ""
    public var supplierRecName: String = ""
    public var enteredByRecName: String = ""
    public var tempNid: Int?
    public var startDate: Date = .distantPast
    public var pkgNid: Int?
    public var brandNid: Int?
    public var itemNid: Int?

    public init() {}
}
