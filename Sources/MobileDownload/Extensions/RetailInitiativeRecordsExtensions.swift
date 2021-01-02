//
//  RetailInitiativeRecordsExtensions.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/10/20.
//

import Foundation

extension Records where T: RetailInitiativeRecord {
    public func getRetailInitiatives(cusNid: Int?) -> [RetailInitiative] {
        var allInitiatives: [RetailInitiative] = []

        for record in getAll() {
            if let cusNid = cusNid {
                if !record.cusNids.contains(cusNid) {
                    continue
                }
            }

            allInitiatives.append(record.retailInitiative)
        }

        return allInitiatives
    }
}
