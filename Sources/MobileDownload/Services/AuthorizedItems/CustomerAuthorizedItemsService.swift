//
//  CustomerAuthorizedItemsService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/4/20.
//
//  Each customer can have up to 10 AuthorizedItemLists (limited only by UI), and each list can have an arbitrary set of ItemNids

import Foundation

public struct CustomerAuthorizedItemsService {
    let allItemNids: Set<Int>

    var hasAuthorizedItems: Bool { !allItemNids.isEmpty }

    func isAuthorizedToBuy(itemNid: Int) -> Bool {
        allItemNids.isEmpty || allItemNids.contains(itemNid)
    }

    init(cusNid: Int) {
        let customer = mobileDownload.customers[cusNid]

        var allItemNids: Set<Int> = []

        for listNid in customer.authorizedItemListNids {
            let list = mobileDownload.authorizedItemLists[listNid]

            allItemNids.formUnion(list.itemNids)
        }

        self.allItemNids = allItemNids
    }
}
