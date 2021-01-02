//
//  WarehouseSellabilityOverrideService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//

import Foundation

public class WarehouseSellabilityOverrideService {
    let itemOverrides: [Int: WarehouseSellabilityOverride]

    public init(_ warehouseSellabilityOverrides: [WarehouseSellabilityOverride]) {
        itemOverrides = Dictionary(uniqueKeysWithValues: warehouseSellabilityOverrides.map { ($0.itemNid, $0) })
    }

    public func isCanBuyRestricted(itemNid: Int) -> Bool {
        if let overrides = itemOverrides[itemNid] {
            if !overrides.canBuy {
                return true
            }
        }
        return false
    }

    public func isCanIssueRestricted(itemNid: Int) -> Bool {
        if let overrides = itemOverrides[itemNid] {
            if !overrides.canIssue {
                return true
            }
        }
        return false
    }

    public func isCanSellRestricted(itemNid: Int) -> Bool {
        if let overrides = itemOverrides[itemNid] {
            if !overrides.canSell {
                return true
            }
        }
        return false
    }

   public  func isCanSampleRestricted(itemNid: Int) -> Bool {
        if let overrides = itemOverrides[itemNid] {
            if !overrides.canSample {
                return true
            }
        }
        return false
    }
}
