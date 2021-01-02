import Foundation

public final class WebLinkRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var itemNid: Int?
    public var brandNid: Int?
    public var customerNid: Int?
    public var chainNid: Int?
    public var webURL: String = ""
    public var webLinkAudienceNid: Int?
    public var fromDate: Date?
    public var thruDate: Date?
    public var customerRuleNidBlob: String = ""
    public var itemRuleNidBlob: String = ""
    public var webLinkContentType: eWebLinkContentType = .WebPage

    public init() {}
}

extension WebLinkRecord {
    public enum eWebLinkRecordType: Int, Codable {
        case None = 0
        case Item = 1
        case Brand = 2
        case Customer = 3
        case Chain = 4
    }

    public enum eWebLinkContentType: Int, Codable {
        case Unspecified = 0
        case Spreadsheet = 1
        case Presentation = 2
        case PDF = 3
        case Word = 4
        case Video = 5
        case ARModel = 6
        case WebPage = 7
        case Other = 8
    }

    public var webLinkRecordType: eWebLinkRecordType {
        if itemNid != nil {
            return eWebLinkRecordType.Item
        } else if brandNid != nil {
            return eWebLinkRecordType.Brand
        } else if customerNid != nil {
            return eWebLinkRecordType.Customer
        } else if chainNid != nil {
            return eWebLinkRecordType.Chain
        } else {
            return eWebLinkRecordType.None
        }
    }
}
