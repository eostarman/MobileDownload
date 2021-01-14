import Foundation
import MoneyAndExchangeRates

public final class PromoSectionRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    private var itemsAndNote = ItemsAndNote()

    public var isMixAndMatch: Bool = false
    public var caseMinimum: Int = 0
    public var promoCodeNid: Int = 0
    public var startDate: Date = .distantPast
    public var endDate: Date?
    public var isBuyXGetY: Bool = false
    public var qtyX: Int = 0
    public var qtyY: Int = 0
    public var isActualPrice: Bool = false
    public var isPercentOff: Bool = false
    public var isQualifiedPromo: Bool = false
    public var triggerGroup1Minimum: Int = 0
    public var triggerGroup2Minimum: Int = 0
    public var triggerGroup3Minimum: Int = 0
    public var triggerGroup4Minimum: Int = 0
    public var triggerGroup5Minimum: Int = 0
    public var isContractPromo: Bool = false
    public var promoPlan: ePromoPlan = .Default
    public var isCaseRollupPromo: Bool = false
    public var isFullPriceTriggers: Bool = false
    public var isDayOfWeekPromo: Bool = false
    public var sundayPromo: Bool = false
    public var mondayPromo: Bool = false
    public var tuesdayPromo: Bool = false
    public var wednesdayPromo: Bool = false
    public var thursdayPromo: Bool = false
    public var fridayPromo: Bool = false
    public var saturdayPromo: Bool = false
    public var isProratedAmount: Bool = false
    public var additionalFeePromo_IsTax: Bool = false
    public var isFeatured: Bool = false

    public func isActiveOnDate(_ date: Date) -> Bool {
        date >= startDate && (endDate == nil || date <= endDate!)
    }
    
    public func isAvailableOnWeekday(_ date: Date) -> Bool {
        if !isDayOfWeekPromo {
            return true
        }
        
        let weekday = Calendar.current.component(.weekday, from: date) // 1=Sunday
        
        switch weekday {
        case 1: return sundayPromo
        case 2: return mondayPromo
        case 3: return tuesdayPromo
        case 4: return wednesdayPromo
        case 5: return thursdayPromo
        case 6: return fridayPromo
        case 7: return saturdayPromo
        default:
            return false
        }
    }

    public init() {}
}

extension PromoSectionRecord {
    /// so, what's this all about? When we download promoSections the promoItems (and the note strangely) are encoded. Decoding all promo sections for an Odom download with 20k promo sections
    /// consumes 100MB. So, I want to keep the encoded data around until it's really needed (e.g. when entering an order for a customer where only *some* promo sections will apply)
    public class ItemsAndNote: Codable {
        public var encoded: String?
        public var note: String?
        public var promoItems: [PromoItem]

        public init() {
            promoItems = []
        }

        public init(promoItems: [PromoItem], note: String?) {
            self.promoItems = promoItems
            self.note = note
        }

        public func decodeIfNecessary(recNid: Int) {
            if let encoded = encoded {
                guard let decoder = mobileDownload.promoSectionDecoder else {
                    fatalError("A decoder is required if there's encoded data")
                }
                // let itemsAndNote = PromoItemDecoder.getPromoItemsAndNote(blob: encoded, promoSectionNid: recNid)
                let itemsAndNote = decoder(encoded, recNid)
                self.encoded = nil
                note = itemsAndNote.note
                promoItems = itemsAndNote.promoItems
            }
        }
    }

    public func setEncodedItemsAndNote(encoded: String) {
        itemsAndNote.encoded = encoded
    }

    public func getNote() -> String? {
        itemsAndNote.decodeIfNecessary(recNid: recNid)
        return itemsAndNote.note
    }

    public func setNote(note: String?) {
        itemsAndNote.decodeIfNecessary(recNid: recNid)
        itemsAndNote.note = note
    }

    public func getPromoItems() -> [PromoItem] {
        itemsAndNote.decodeIfNecessary(recNid: recNid)
        return itemsAndNote.promoItems
    }

    public func setPromoItems(_ promoItems: [PromoItem]) {
        itemsAndNote.decodeIfNecessary(recNid: recNid)
        itemsAndNote.promoItems = promoItems
    }
}

extension PromoSectionRecord {
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
}
