//
//  BarCodeRecordsExtensions.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 10/21/20.
//

import Foundation

extension Records where T: BarCodeRecord {
    public func findItems(_ upc: UPC) -> [Int] {
        var itemNids = [Int]()

        for record in getAll() {
            let barcode = UPC(record.recKey)

            if barcode == upc {
                itemNids.append(record.itemNid)
            }
        }

        return itemNids
    }
}
