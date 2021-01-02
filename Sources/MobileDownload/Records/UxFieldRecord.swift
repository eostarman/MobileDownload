import MoneyAndExchangeRates


public final class UxFieldRecord: Record {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var limitedRecNids: Set<Int> = []

    public var part1UxFieldNid: Int = 0
    public var part2UxFieldNid: Int = 0
    public var part3UxFieldNid: Int = 0
    public var part4UxFieldNid: Int = 0
    public var part5UxFieldNid: Int = 0
    public var part6UxFieldNid: Int = 0
    public var part7UxFieldNid: Int = 0
    public var part8UxFieldNid: Int = 0
    public var part9UxFieldNid: Int = 0
    public var part10UxFieldNid: Int = 0
    public var part1IsRepeating: Bool = false
    public var part2IsRepeating: Bool = false
    public var part3IsRepeating: Bool = false
    public var part4IsRepeating: Bool = false
    public var part5IsRepeating: Bool = false
    public var part6IsRepeating: Bool = false
    public var part7IsRepeating: Bool = false
    public var part8IsRepeating: Bool = false
    public var part9IsRepeating: Bool = false
    public var part10IsRepeating: Bool = false
    public var choice1: String = ""
    public var choice2: String = ""
    public var choice3: String = ""
    public var choice4: String = ""
    public var choice5: String = ""
    public var choice6: String = ""
    public var choice7: String = ""
    public var choice8: String = ""
    public var choice9: String = ""
    public var choice10: String = ""
    public var intMinimum: Int = 0
    public var intMaximum: Int = 0
    public var moneyMinimum: Int = 0
    public var moneyMaximum: Int = 0
    public var recordName: String = ""
    public var maxTextLength: Int = 0
    public var digitsBeforeDecimal: Int = 0
    public var digitsAfterDecimal: Int = 0
    public var uxFieldType: eUxFieldType = .IsText
    public var hostRecordName: String = ""
    public var surveyQuestionText: String = ""
    public var singularName: String = ""
    public var pluralName: String = ""
    public var parts_SingularName: String = ""
    public var parts_PluralName: String = ""
    // public var nRecordSelectionNids: Int = 0

    public init() {}
}

extension UxFieldRecord {
    public enum eUxFieldType: Int, Codable {
        case IsYesNo = 0
        case IsInteger = 1
        case IsText = 2
        case IsDate = 3
        case IsTime = 4
        case IsDecimal = 5
        case IsMoney = 6
        case IsRecord = 7
        case IsImage = 8
        case IsPercent = 9
        case IsChoice = 10
        case IsDateTime = 11
        case IsMultiPartUxField = 12
        case IsSignature = 13
    }
}
