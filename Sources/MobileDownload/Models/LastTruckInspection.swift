//
//  TruckInspection.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 12/23/20.
//

import Foundation

/// This is a truck inspection downloaded from the web service (a prior truck inspection)
public class LastTruckInspection {
    public var tiInspectionNid: Int = 0
    public var inspectionTime: Date = .distantPast
    public var inspectorEmpNid: Int = 0
    public var truckNid: Int = 0
    public var odoReading: Int = 0
    public var truckCondition: String = ""
    public var comment: String = ""
    public var isDriverInsp: Bool = false
    public var isMechanicInsp: Bool = false

    public var defectiveTiItemNids: Set<Int> = []

    public var tempReading: Double?
    public var truckNumber: String = ""
    public var trailerNumber: String = ""

    public init() { }
}
