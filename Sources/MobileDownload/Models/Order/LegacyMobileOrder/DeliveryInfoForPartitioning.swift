//
//  DeliveryInfoForPartitioning.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/31/20.
//

import Foundation

extension MobileOrder {
    public struct DeliveryInfoForPartitioning: Codable {
        let isOffScheduleDelivery: Bool
        let driverNid: Int
        let deliveryDate: Date

        public init(isOffScheduleDelivery: Bool, driverNid: Int, deliveryDate: Date) {
            self.isOffScheduleDelivery = isOffScheduleDelivery
            self.driverNid = driverNid
            self.deliveryDate = deliveryDate

        }
    }
}
