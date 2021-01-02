//
//  DownloadedDelivery.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/29/20.
//
//  Delivery drivers will get a collection of pre-sold orders to deliver to their customers

import Foundation

public struct DownloadedDelivery: Identifiable {
    public var id: Int { orderNumber }
    public let orderNumber: Int
}
