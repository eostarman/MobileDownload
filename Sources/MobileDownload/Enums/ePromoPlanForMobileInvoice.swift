//  Created by Michael Rutherford on 1/23/21.

//import Foundation
//
//public enum ePromoPlanForMobileInvoice: Int, Comparable {
//    public static func < (lhs: ePromoPlanForMobileInvoice, rhs: ePromoPlanForMobileInvoice) -> Bool {
//        lhs.rawValue < rhs.rawValue
//    }
//
//    case Unsupported = 0
//
//    // the case values are the sequence the DiscountCalculator will process these promos in
//    // We want to do default promos last so we know whether or not to adjust the front line price, based on the CMA promos (ie $20 price item with $15 CMA gets $5 disc max)
//
//    case CMAOnInvoice = 1
//    case CCFOnInvoice = 2
//    case CTMOnInvoice = 3
//    /// Default, Stackable and also AdditionalFee
//    case Default = 4
//    case OffInvoiceAccrual = 5
//
//    public init(_ promoPlan: ePromoPlan) {
//
//        switch promoPlan {
//        case .AdditionalFee: self = .Default
//        case .CCFOffInvoice: self = .Unsupported
//        case .CCFOnInvoice: self = .CCFOnInvoice
//        case .CMAOffInvoice: self = .Unsupported
//        case .CMAOnInvoice: self = .CMAOnInvoice
//        case .CTMOffInvoice: self = .Unsupported
//        case .CTMOnInvoice: self = .CTMOnInvoice
//        case .Default: self = .Default
//        case .OffInvoiceAccrual: self = .OffInvoiceAccrual
//        case .Stackable: self = .Default
//        }
//    }
//}
