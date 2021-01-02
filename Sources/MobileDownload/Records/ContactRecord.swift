public final class ContactRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var ordersFlag: Bool = false
    public var paymentsFlag: Bool = false
    public var decisionMakerFlag: Bool = false
    public var serviceFlag: Bool = false
    public var autoFaxFlag: Bool = false
    public var autoEmailFlag: Bool = false
    public var ownerFlag: Bool = false
    public var buyerFlag: Bool = false

    public var cusNid: Int = 0
    public var contactTitle: String = ""
    public var contactNote: String = ""
    public var phoneNumber: String = ""
    public var phoneType: eContactPhoneType = .Cell
    public var phoneNumber2: String = ""
    public var phoneType2: eContactPhoneType = .Office
    public var email: String = ""
    public var emailType: eContactEmailType = .Office
    public var sequence: Int = 0
    public var preferredContactMethod: ePreferredContactMethod = .Email
    public var crmNote: String = ""

    public init() {}
}

extension ContactRecord {
    public enum ePreferredContactMethod: Int, Codable {
        case Unknown = 0
        case OfficePhone = 1
        case HomePhone = 2
        case CellPhone = 3
        case Fax = 4
        case Email = 5
        case TextMessage = 6
    }

    public enum eContactPhoneType: Int, Codable {
        case Office = 0
        case Home = 1
        case Cell = 2
        case Fax = 3
        case Other = 4
    }

    public enum eContactEmailType: Int, Codable {
        case Office = 0
        case Home = 1
        case Other = 2
    }

    public func getPhoneDescription(phoneNumber: String, phoneType: eContactPhoneType) -> String {
        switch phoneType {
        case .Office: return phoneNumber
        case .Home: return "\(phoneNumber) (home)"
        case .Cell: return "\(phoneNumber) (cell)"
        case .Fax: return "\(phoneNumber) (fax)"
        case .Other: return phoneNumber
        }
    }

    public func getEmailDescription(email: String, emailType: eContactEmailType) -> String {
        switch emailType {
        case .Office: return email
        case .Home: return "\(email) (home)"
        case .Other: return email
        }
    }

    public func getPreferredContactMethod() -> String? {
        switch preferredContactMethod {
        case .OfficePhone: return "office"
        case .HomePhone: return "home"
        case .CellPhone: return "cell"
        case .Fax: return "fax"
        case .Email: return "email"
        case .TextMessage: return "text"
        default: return nil
        }
    }
}
