import Foundation

public final class UxSurveyRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var description: String = ""
    public var isMandatory: Bool = false
    public var fromDate: Date = .distantPast
    public var thruDate: Date?
    public var cusNidsBlob: String = ""
    public var isScoreable: Bool = false
    public var isMandatoryOneTime: Bool = false
    public var mandatoryThresholdInDays: Int = 0
    public var isMandatoryWeekly: Bool = false
    public var isMandatoryBiWeekly: Bool = false
    public var isMandatoryMonthly: Bool = false

    public var mandatoryAlways: Bool { return isMandatory && !isMandatoryOneTime && !isMandatoryWeekly && !isMandatoryBiWeekly && !isMandatoryMonthly }
    public var mandatoryOneTime: Bool { return isMandatory && isMandatoryOneTime }
    public var mandatoryWeekly: Bool { return isMandatory && isMandatoryWeekly }
    public var mandatoryBiWeekly: Bool { return isMandatory && isMandatoryBiWeekly }
    public var mandatoryMonthly: Bool { return isMandatory && isMandatoryMonthly }

    public init() {}
}
