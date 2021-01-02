//
//  BrandFamilyCanBuyRestrictionsService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/4/20.
//
//  Customers can be limited to a particular list of brand families, as can a whole territory

import Foundation

public struct BrandFamilyCanBuyRestrictionsService {
    let customerBrandFamilies: Set<Int>
    let territoryBrandFamilies: Set<Int>

    func isAllowedForCustomer(brandFamilyNid: Int) -> Bool {
        customerBrandFamilies.isEmpty || customerBrandFamilies.contains(brandFamilyNid)
    }

    func isAllowedForTerritory(brandFamilyNid: Int) -> Bool {
        territoryBrandFamilies.isEmpty || territoryBrandFamilies.contains(brandFamilyNid)
    }

    init(cusNid: Int) {
        let customer = mobileDownload.customers[cusNid]
        customerBrandFamilies = customer.brandFamilyAssignments

        if let territoryNid = customer.territoryNid {
            let territory = mobileDownload.territories[territoryNid]
            territoryBrandFamilies = territory.brandFamilyAssignments
        } else {
            territoryBrandFamilies = []
        }
    }
}
