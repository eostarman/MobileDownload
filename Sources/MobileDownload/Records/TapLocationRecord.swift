import Foundation

public final class TapLocationRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var cusNid: Int = 0
    public var mostRecentSurveyEmpNid: Int?
    public var mostRecentSurveyEntryTime: Date?

    public init() {}
}
