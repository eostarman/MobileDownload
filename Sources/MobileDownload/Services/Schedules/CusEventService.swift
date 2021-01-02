//
//  CusEventService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/11/20.
//

import Foundation

public struct CusEventService {
    public init() { }
    
    public func isCustomerScheduledForPresell(_ customer: CustomerRecord, on date: Date) -> Bool {
        let cusEvents = customer.cusEvents.filter { $0.task == .Presell }
        for cusEvent in cusEvents {
            if cusEvent.isScheduled(date) {
                return true
            }
        }
        return false
    }
}
