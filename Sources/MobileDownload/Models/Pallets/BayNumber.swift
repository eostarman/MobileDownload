//
//  TruckBay.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/29/20.
//

import Foundation

/// a side-loaded truck has a driver/passenger side and also a bay number (1 is closest to the cab where the driver sits)
/// a rear-loaded truck (for over-the-road routes such as bulk deliveries to a single large customer or warehouse as an example, but also for other routes)
/// if you sort these,
public struct BayNumber: Hashable, Identifiable, Equatable, Comparable {
    public var id: String { name }
    public let name: String
    public let baySide: eBaySide
    public let bayNumber: Int

    public enum eBaySide: String {
        case Driver
        case Passenger
        case Trailer
    }

    private var baySideComparisonValue: Int {
        switch baySide {
        case .Driver:
            return 0
        case .Passenger:
            return 1
        case .Trailer:
            return 2
        }
    }

    public static func < (lhs: BayNumber, rhs: BayNumber) -> Bool {
        if lhs.baySide != rhs.baySide {
            return lhs.baySideComparisonValue < rhs.baySideComparisonValue // Driver, Passenger, Trailer
        }

        return lhs.bayNumber < rhs.bayNumber
    }

    public static func == (lhs: BayNumber, rhs: BayNumber) -> Bool {
        return (lhs.name == rhs.name)
    }

    public init() {
        name = "x"
        baySide = .Trailer
        bayNumber = 0
    }

    public init(_ bay: String) {
        name = bay
        let pattern = "^\\s*([dp])\\s*(\\d+)\\s*$" // looking for "D1" or "P2" or "D 1" or "P 12" ...
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        if let match = regex.firstMatch(in: bay, options: [.anchored], range: NSRange(location: 0, length: bay.count)) {
            let baySideRange = Range(match.range(at: 1), in: bay)
            let bayNumberRange = Range(match.range(at: 2), in: bay)

            if let baySideRange = baySideRange, let bayNumberRange = bayNumberRange {
                let baySide = String(bay[baySideRange])
                let bayNumber = String(bay[bayNumberRange])

                self.baySide = baySide == "d" || baySide == "D" ? .Driver : .Passenger
                self.bayNumber = Int(bayNumber) ?? 0
                return
            }
        }

        baySide = .Trailer
        bayNumber = Int(bay) ?? 0 // it could be a number if the pallet is in a back-loaded truck (over-the-road transfers)
    }
}
