//
//  WarehouseCanSellService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//
// answers the question: can a warehouse "sell" an item

import Foundation

public class WarehouseCanSellService {
    let getAltPackFamilyNid: (Int) -> Int // map an itemNid --> altPackFamilyNid

    let altPackFamilyNids: Set<Int>

    let sellabilityOverrideService: WarehouseSellabilityOverrideService

    func isListedInWarehousesSellableItems(itemNid: Int) -> Bool {
        if altPackFamilyNids.isEmpty {
            return true
        }

        let altPackFamilyNid = getAltPackFamilyNid(itemNid)
        return altPackFamilyNids.contains(altPackFamilyNid)
    }

    // used for unit tests
    public init(sellableAltPackFamilyNids: [Int], warehouseSellabilityOverrides: [WarehouseSellabilityOverride], getAltPackFamilyNid: @escaping (Int) -> Int) {
        self.getAltPackFamilyNid = getAltPackFamilyNid
        altPackFamilyNids = Set(sellableAltPackFamilyNids)
        sellabilityOverrideService = WarehouseSellabilityOverrideService(warehouseSellabilityOverrides)
    }

    init(whseNid: Int) {
        func getAltPackFamilyNid(itemNid: Int) -> Int {
            mobileDownload.items[itemNid].altPackFamilyNid
        }

        self.getAltPackFamilyNid = getAltPackFamilyNid

        let warehouse = mobileDownload.warehouses[whseNid]

        sellabilityOverrideService = WarehouseSellabilityOverrideService(warehouse.warehouseSellabilityOverrides)

        if let sellableProductSetNid = warehouse.sellableItemsProductSetNid {
            altPackFamilyNids = mobileDownload.productSets[sellableProductSetNid].altPackFamilyNids
        } else {
            altPackFamilyNids = []
        }
    }

    public func canBuy(itemNid: Int) -> Bool {
        isListedInWarehousesSellableItems(itemNid: itemNid) && !sellabilityOverrideService.isCanBuyRestricted(itemNid: itemNid)
    }

    public func canIssue(itemNid: Int) -> Bool {
        isListedInWarehousesSellableItems(itemNid: itemNid) && !sellabilityOverrideService.isCanIssueRestricted(itemNid: itemNid)
    }

    public func canSell(itemNid: Int) -> Bool {
        isListedInWarehousesSellableItems(itemNid: itemNid) && !sellabilityOverrideService.isCanSellRestricted(itemNid: itemNid)
    }

    public func canSample(itemNid: Int) -> Bool {
        isListedInWarehousesSellableItems(itemNid: itemNid) && !sellabilityOverrideService.isCanSampleRestricted(itemNid: itemNid)
    }
}
