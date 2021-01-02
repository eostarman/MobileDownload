//
//  CustomerNote.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/19/20.
//

import Foundation

/// A customer-specific note downloaded from eoStar  (dbo.CustomerNotes) - each customer can have a history of these entered by different people over time
public struct CustomerNote: Identifiable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var cusNid: Int = 0
    public var entryTime: Date = .distantPast
    public var entryEmpNid: Int = 0
    public var isCollectionsNote: Bool = false
    public var isServiceCallNote: Bool = false
    public var activeFlag: Bool = false
    public var note: String = ""

    public init() { }
}
