//
//  ItemAllocation.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/4/20.
//

import Foundation

// allocation plugin: an allocation of an item (to a sales-person or customer)
public struct ItemAllocation {
    public var whseNid: Int = 0
    public var cusNid: Int = 0
    public var itemNid: Int = 0
    public var note: String = ""
    public var allocationDate: Date = .distantPast
    public var allocationThruDate: Date = .distantFuture
    public var qtyAllocated: Int = 0
    public var qtyDelivered: Int = 0

    public init() { }

    public func Contains(orderShippedDate: Date) -> Bool {
        allocationDate <= orderShippedDate && orderShippedDate <= allocationThruDate
    }

    public var qtyAvailable: Int {
        let qtyAvailable = qtyAllocated - qtyDelivered

        if qtyAvailable > qtyAllocated {
            return qtyAllocated
        }

        if qtyAvailable < 0 {
            return 0
        }

        return qtyAvailable
    }
}
