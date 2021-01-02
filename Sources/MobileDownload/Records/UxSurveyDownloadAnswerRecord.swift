import Foundation

public final class UxSurveyDownloadAnswerRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var uxSurveyNid: Int = 0
    public var cusNid: Int = 0
    public var uxFieldNid: Int = 0
    public var uxSubFieldNid: Int = 0
    public var repeater_index: Int = 0
    public var multiPart_index: Int = 0
    public var uxFieldType: UxFieldRecord.eUxFieldType = .IsText
    public var intValue: Int = 0
    public var recNidValue: Int = 0
    public var decimalValue: Decimal?
    public var textValue: String = ""
    public var bitValue: Bool = false
    public var dateTimeValue: Date?
    public var base64Image: String = ""
    public var recordName: String = ""
    public var score: Int = 0

    public init() {}
}
