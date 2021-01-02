//
//  AllocationService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//
// answers the question: does a customer have an active allocation of an item on a certain date, and how much do they have remaining
// based on deliveries during the allocation date range

import Foundation

public struct CusAllocationsService {
    public let allocations: [ItemAllocation]

    public init(cusNid: Int, whseNid: Int, shipDate: Date) {
        var allocations: [ItemAllocation] = []

        for allocation in mobileDownload.cusAllocations {
            if cusNid > 0 {
                if cusNid != allocation.cusNid || whseNid != allocation.whseNid || !allocation.Contains(orderShippedDate: shipDate) {
                    continue
                }
            }

            allocations.append(allocation)
        }

        self.allocations = allocations
    }

    func hasAllocation(itemNid: Int) -> Bool {
        for allocation in allocations {
            if allocation.itemNid == itemNid {
                return true
            }
        }

        return false
    }
}
