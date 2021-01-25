//  Created by Michael Rutherford on 1/22/21.

import Foundation

public enum ePromoPlan: Int, Codable {
    case Default = 0
    case Stackable = 1
    case CMAOnInvoice = 2
    case CCFOnInvoice = 3
    case CTMOnInvoice = 4
    case CMAOffInvoice = 5
    case CCFOffInvoice = 6
    case CTMOffInvoice = 7
    case AdditionalFee = 8
    case OffInvoiceAccrual = 9
}
