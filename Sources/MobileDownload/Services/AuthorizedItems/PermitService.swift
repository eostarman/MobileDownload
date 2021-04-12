//
//  PermitService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/4/20.
//

import Foundation

// note: there are Permits (these identify which permit is need for particular items) and there are CusPermits (the permits actually
// held by the customer)

public struct PermitService {
    var itemsCoveredByPermit: [Int: Set<Int>] = [:]
    let cusPermits: [CusPermit]

    init(cusNid: Int) {
        for permit in mobileDownload.permits.getAll() {
            itemsCoveredByPermit[permit.recNid] = permit.altPackFamilyNids
        }

        let customer = mobileDownload.customers[cusNid]

        cusPermits = customer.cusPermits
    }

    func getPermitsThatMayBeUsedToSellThisItem(altPackFamilyNid: Int) -> [Int] {
        var permitNids: [Int] = []

        for permit in mobileDownload.permits.getAll() {
            if permitAppliesToItem(permitNid: permit.recNid, altPackFamilyNid: altPackFamilyNid) {
                permitNids.append(permit.recNid)
            }
        }

        return permitNids
    }

    func getPermitStatus(altPackFamilyNid: Int, shipDate: Date) -> AuthorizedItemStatus {
        let permitsNeededForThisItem = getPermitsThatMayBeUsedToSellThisItem(altPackFamilyNid: altPackFamilyNid)
        if permitsNeededForThisItem.isEmpty {
            return .OK // this item doesn't require the customer to have a permit in order to be sold
        }

        // the permits that apply to this item and that are held by this customer
        let permitsForThisItem = cusPermits.filter { permitsNeededForThisItem.contains($0.permitNid) }
        if permitsForThisItem.count == 0 {
            return .NoPermit
        }

        // note that there may be multiple permits that can be used to sell this item; one could be expired, but another one is good
        for cusPermit in permitsForThisItem {
            if !cusPermit.isDelinquent, !cusPermit.isSuspended, !cusPermit.isCancelled, cusPermit.thruDate >= shipDate {
                return .OK
            }
        }

        for cusPermit in permitsForThisItem {
            if cusPermit.isDelinquent {
                return .DelinquentPermit
            }
            if cusPermit.isSuspended {
                return .SuspendedPermit
            }
            if cusPermit.isCancelled {
                return .CancelledPermit
            }
            if cusPermit.thruDate < shipDate {
                return .ExpiredPermit
            }
        }

        return .NoPermit
    }

    func permitAppliesToItem(permitNid: Int, altPackFamilyNid: Int) -> Bool {
        if let altPackFamilyNids = itemsCoveredByPermit[permitNid] {
            return altPackFamilyNids.contains(altPackFamilyNid)
        }

        return false
    }

    func getCusPermits(altPackFamilyNid: Int) -> [CusPermit] {
        var cusPermits: [CusPermit] = []

        for cusPermit in cusPermits {
            if permitAppliesToItem(permitNid: cusPermit.permitNid, altPackFamilyNid: altPackFamilyNid) {
                cusPermits.append(cusPermit)
            }
        }

        return cusPermits
    }
}
