//
//  ItemRecordExtensions.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/25/20.
//

import Foundation

extension Records where T: ItemRecord {
    public func packName(itemNid: Int) -> String {
        self[itemNid].packName.lowercased()
    }

    public func tinyPackName(itemNid: Int) -> String {
        let realPackName = self[itemNid].packName.lowercased()

        var result = realPackName.replacingOccurrences(of: "[^a-z]", with: "", options: .regularExpression)

        if result.count > 2 {
            result = String(result.prefix(2))
        }

        return result
    }

    public func findByCaseOrRetailUPC(_ upc: UPC) -> [Int] {
        var primaryPackNids = [Int]()

        for item in getAll() {
            if item.isPrimaryPack() {
                if upc == UPC(item.caseUPC) || upc == UPC(item.retailUPC) {
                    primaryPackNids.append(item.recNid)
                }
            }
        }

        return primaryPackNids
    }
}
