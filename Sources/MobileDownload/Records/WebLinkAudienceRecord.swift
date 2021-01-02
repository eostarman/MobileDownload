public final class WebLinkAudienceRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var webLinkAudience: eWebLinkAudience = .Product

    public init() {}
}

extension WebLinkAudienceRecord {
    public enum eWebLinkAudience: Int, Codable {
        case Product = 0
        case Retailer = 1
    }
}
