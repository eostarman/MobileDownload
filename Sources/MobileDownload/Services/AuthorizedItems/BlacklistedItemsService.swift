//
//  BlacklistedItemsService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//
// Items can be black-listed for a customer, chain or sales channel (at the altPackFamilyNid level); also, brands can be blacklisted in a county

import Foundation

public struct BlacklistedItemsService {
    var customerBlacklistedItems: Set<Int> = []
    var salesChannelBlacklistedItems: Set<Int> = []
    var chainBlacklistedItems: Set<Int> = []
    var countyBlacklistedBrands: Set<Int> = []

    func isBlacklistedForCustomerSalesChannelOrChain(altPackFamilyNid: Int) -> Bool {
        customerBlacklistedItems.contains(altPackFamilyNid) || salesChannelBlacklistedItems.contains(altPackFamilyNid) || chainBlacklistedItems.contains(altPackFamilyNid)
    }

    func isBrandBlacklistedInCounty(brandNid: Int?) -> Bool {
        guard let brandNid = brandNid else {
            return false
        }

        return countyBlacklistedBrands.contains(brandNid)
    }

    init(cusNid: Int) {
        let customer = mobileDownload.customers[cusNid]

        customerBlacklistedItems = customer.blacklistedItems

        if let salesChannelNid = customer.salesChannelNid {
            salesChannelBlacklistedItems = mobileDownload.salesChannels[salesChannelNid].blacklistedItems
        }

        if let chainNid = customer.chainNid {
            chainBlacklistedItems = mobileDownload.chains[chainNid].blacklistedItems
        }

        if let countyNid = customer.countyNid {
            let county = mobileDownload.counties[countyNid]

            if let blacklistLikeCountyNid = county.BlacklistLikeCountyNid {
                countyBlacklistedBrands = mobileDownload.counties[blacklistLikeCountyNid].blacklistedBrands
            } else {
                countyBlacklistedBrands = county.blacklistedBrands
            }
        }
    }
}
