public final class UxSurveyLineRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var uxSurveyNid: Int = 0
    public var uxFieldNid: Int = 0
    public var lineNumber: Int = 0
    public var triggerUxFieldNid: Int = 0
    public var triggerValue: String = ""
    public var maxScore: Int = 0
    public var isBlind: Bool = false
    public var isRequired: Bool = false

    public init() {}
}
