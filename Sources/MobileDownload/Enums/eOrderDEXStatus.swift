//
//  eOrderDEXStatus.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/31/20.
//

extension MobileOrder {
    public enum eOrderDEXStatus: Int, Codable, CaseIterable {
        case NotApplicable = 0
        case NotTransmitted = 1
        case Failed = 2
        case Succeeded = 3
        case Skipped = 4
    }
}
