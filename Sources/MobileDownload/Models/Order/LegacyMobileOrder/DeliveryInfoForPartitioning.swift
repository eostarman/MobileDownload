//
//  DeliveryInfoForPartitioning.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/31/20.
//

import Foundation

extension MobileOrder {
    public struct DeliveryInfoForPartitioning: Codable {
        public let isOffScheduleDelivery: Bool
        public let driverNid: Int
        public let deliveryDate: Date

        public init(isOffScheduleDelivery: Bool, driverNid: Int, deliveryDate: Date) {
            self.isOffScheduleDelivery = isOffScheduleDelivery
            self.driverNid = driverNid
            self.deliveryDate = deliveryDate

        }
    }
}
