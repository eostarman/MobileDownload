import Foundation

public final class PaymentTermRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var termDiscountDays: Int = 0
    public var termDiscountPct: Decimal?
    public var isCharge: Bool = false
    public var paymentProcessing: ePaymentProcessing?
    public var dayOfMonth: Int = 0
    public var daysToPay: Int = 0
    public var creditCalendarNid: Int?
    public var cashOnlyNoChecks: Bool = false
    public var remitToInfo: String?

    public init() {}
}

extension PaymentTermRecord {
    public var isEFT: Bool {
        switch paymentProcessing {
        case .Fintech, .Nacha, .Uff, .UffSend, .X12, .X12Send, .Coke, .CreditCardOnFile, .iControl, .AB_BofA, .AB, .CokeFintech, .CokeCIS:
            return true
        default:
            return false
        }
    }

    public var isCOD: Bool { !isCharge && !isEFT }

    public enum ePaymentProcessing: Int, Codable, CaseIterable {
        case Manual = 0
        case Nacha
        case Fintech
        case UffSend
        case UffReceive
        case Uff
        case X12Send
        case X12Receive
        case X12
        case Coke
        case CreditCardOnFile
        case iControl
        case AB_BofA // AB_BofA goes through the Bank of america process, AB goes through the standard EDI process
        case AB
        case CokeFintech
        case CokeCIS

        public var isEFT: Bool {
            switch self {
            case .Fintech, .Nacha, .Uff, .UffSend, .X12, .X12Send, .Coke, .CreditCardOnFile, .iControl, .AB_BofA, .AB, .CokeFintech, .CokeCIS:
                return true
            default:
                return false
            }
        }

        public init?(caseName: String) {
            for value in ePaymentProcessing.allCases where caseName == "\(value)" {
                self = value
                return
            }

            return nil
        }
    }
}
