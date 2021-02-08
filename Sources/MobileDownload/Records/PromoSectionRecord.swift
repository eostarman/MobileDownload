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
    
    public var isTax: Bool {
        promoPlan == .AdditionalFee && additionalFeePromo_IsTax
    }

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
        /// An encoding of the note and the individual promoItem entries (as encoded into mobileDownload by eonetservice. This is set to nil when it's "consumed" (i.e. decoded)
        private var encoded: String?
        
        private var note: String?
        
        /// On any given date, there is exactly one promoItem for each itemNid
        private var cachedPromoDate: Date? = nil
        private var cachedPromoItems: [PromoItem] = []
        private var cachedPromoItemsByItemNid: [Int: PromoItem] = [:]
        
        private var allPromoItems: [PromoItem] {
            didSet {
                cachedPromoDate = nil
                cachedPromoItems = []
                cachedPromoItemsByItemNid = [:]
            }
        }

        public init() {
            allPromoItems = []
        }

        public init(promoItems: [PromoItem], note: String?) {
            self.allPromoItems = promoItems
            self.note = note
        }
        
        public func setEncoded(encoded: String) {
            self.encoded = encoded
        }
        
        public func setPromoItems(_ promoItems: [PromoItem]) {
            self.allPromoItems = promoItems
        }
        
        public func setNote(promoSectionRecNid: Int, note: String?) {
            decodeIfNecessary(promoSectionRecNid)
            self.note = note
        }
        
        public func getNote(promoSectionRecNid: Int) -> String? {
            decodeIfNecessary(promoSectionRecNid)
            return note
        }
        
        public func getPromoItem(promoSectionRecNid: Int, promoDate: Date, itemNid: Int) -> PromoItem? {
            decodeIfNecessary(promoSectionRecNid)
            cacheIfNecessary(promoDate: promoDate)
            return cachedPromoItemsByItemNid[itemNid]
        }
        
        public func getPromoItems(promoSectionRecNid: Int, promoDate: Date) -> [PromoItem] {
            decodeIfNecessary(promoSectionRecNid)
            cacheIfNecessary(promoDate: promoDate)
            return cachedPromoItems
        }
        
        private func cacheIfNecessary(promoDate: Date) {

            // if there's a cachedDate and it maches the one being asked for then we're good
            if let cachedDate = cachedPromoDate, promoDate == cachedDate {
                return
            }
            
            var promoItemsByItemNid: [Int: PromoItem] = [:]
            
            // Odom has a single promoSection with a large collection of promoItems. Each promoItem will have an override on the dates so we need to find the
            // most recently started promoItem for each item (that is active on the given promoDate)
            for promoItem in allPromoItems {
                if !promoItem.isActive(on: promoDate) {
                    continue
                }
                
                if let prior = promoItemsByItemNid[promoItem.itemNid] {
                    if promoItem.fromDateOverride ?? .distantPast >= prior.fromDateOverride ?? .distantPast {
                        promoItemsByItemNid[promoItem.itemNid] = promoItem
                    }
                } else {
                    promoItemsByItemNid[promoItem.itemNid] = promoItem
                }
            }
            
            cachedPromoDate = promoDate
            cachedPromoItemsByItemNid = promoItemsByItemNid
            cachedPromoItems = Array(promoItemsByItemNid.values)
        }

        private func decodeIfNecessary(_ promoSectionRecNid: Int) {
            if let encoded = encoded {
                guard let decoder = mobileDownload.promoSectionDecoder else {
                    fatalError("A decoder is required if there's encoded data")
                }
                // let itemsAndNote = PromoItemDecoder.getPromoItemsAndNote(blob: encoded, promoSectionNid: recNid)
                let itemsAndNote = decoder(encoded, promoSectionRecNid)
                self.encoded = nil
                note = itemsAndNote.note
                allPromoItems = itemsAndNote.allPromoItems
            }
        }
    }

    public func setEncodedItemsAndNote(encoded: String) {
        itemsAndNote.setEncoded(encoded: encoded)
    }

    public func getNote() -> String? {
        itemsAndNote.getNote(promoSectionRecNid: recNid)
    }

    public func setNote(note: String?) {
        itemsAndNote.setNote(promoSectionRecNid: recNid, note: note)
    }
 
    public func getPromoItem(promoDate: Date, itemNid: Int) -> PromoItem? {
        itemsAndNote.getPromoItem(promoSectionRecNid: recNid, promoDate: promoDate, itemNid: itemNid)
    }

    public func getPromoItems(promoDate: Date) -> [PromoItem] {
        itemsAndNote.getPromoItems(promoSectionRecNid: recNid, promoDate: promoDate)
    }
    
    public func setPromoItems(_ promoItems: PromoItem ...) {
        itemsAndNote.setPromoItems(promoItems)
    }

    public func setPromoItems(_ promoItems: [PromoItem]) {
        itemsAndNote.setPromoItems(promoItems)
        
        for promoItem in promoItems {
            promoItem.promoSectionNid = recNid
        }
    }
}
