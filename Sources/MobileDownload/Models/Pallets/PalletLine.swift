//
//  PalletLine.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/29/20.
//

import Foundation

/// A pallet can contain several orders and a single order can span more than 1 pallet. So, this is basically how much of an item on a given order is on a particular pallet.
/// And, what's the sequence on the pallet (what's on the bottom, what's on the top ...)
public struct PalletLine: Identifiable {
    public let id = UUID()

    public var orderNumber: Int = 0
    public var palletID: String = ""
    public var itemNid: Int = 0
    public var completionSeq: Int = 0
    public var qty: Int = 0
    public var bayNumber: BayNumber = BayNumber() // aka "trailerLocation" in c#

    public init() { }
}
