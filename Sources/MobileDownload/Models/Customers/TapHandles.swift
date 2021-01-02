//
//  TapHandles.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 12/23/20.
//

import Foundation

public struct TapHandles {
    public var tapHandlesByLocation: [Int: [TapHandleAtLocation]] = [:]

    public init() { }
    
    public init(tapHandlesByLocation: [Int: [TapHandleAtLocation]]) {
        self.tapHandlesByLocation = tapHandlesByLocation
    }

    public struct TapHandleAtLocation {
        public let tapHandleItemNid: Int
        public let isPermanent: Bool

        public init(tapHandleItemNid: Int, isPermanent: Bool) {
            self.tapHandleItemNid = tapHandleItemNid
            self.isPermanent = isPermanent
        }
    }
}
