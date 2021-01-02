//
//  WarehouseSellabilityOverride.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//

public struct WarehouseSellabilityOverride: Codable {
    public var whseNid: Int = 0
    public var itemNid: Int = 0

    // As designed, these are intended only to add additional restrictions, not to remove them; e.g. if a
    // product isn't CanSell, these overrides aren't meant to say "yes it is", only the other way around.
    public var canBuy: Bool = false
    public var canIssue: Bool = false
    public var canSell: Bool = false
    public var canSample: Bool = false

    public init() { }
}
