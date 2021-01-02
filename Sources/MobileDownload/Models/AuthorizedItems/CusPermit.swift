//
//  CusPermit.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/4/20.
//

import Foundation

public struct CusPermit: Codable {
    public var cusNid: Int = 0
    public var permitNid: Int = 0
    public var licenseNumber: String = ""
    public var thruDate: Date = .distantPast
    public var isSuspended: Bool = false
    public var isDelinquent: Bool = false
    public var isCancelled: Bool = false

    public init() { }
}
