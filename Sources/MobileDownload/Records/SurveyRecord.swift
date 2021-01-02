import Foundation

// mpr: no longer used (this is the old nevron flow-chart based surveys (replaced by UxSurveys)
public final class SurveyRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var description: String = ""
    public var isMandatory: Bool = false
    public var fromDate: Date = .distantPast
    public var thruDate: Date?
    public var cusNidsBlob: String = ""
    public var base64ZippedXmlSurvey: String = ""
    public var isForPresellersOnly: Bool = false

    public init() {}
}
