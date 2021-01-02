//
//  RetailInitiative.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/10/20.
//

import Foundation
import MoneyAndExchangeRates

/// the downloaded retail initiative taken from RetailInitiativeRecord after parsing the XML
public class RetailInitiative: Identifiable, Codable {
    public var id: Int
    public var fromDate: Date?
    public var thruDate: Date?
    public var cusNids: Set<Int>
    public var description: String
    public var sections: [Section]

    public init() {
        id = 0
        cusNids = []
        description = ""
        sections = []
    }

    public init(id: Int, fromDate: Date?, thruDate: Date?, cusNids: Set<Int>, description: String) {
        self.id = id
        self.fromDate = fromDate
        self.thruDate = thruDate
        self.cusNids = cusNids
        self.description = description
        sections = []
    }

    public func getDateDescription() -> String {

        let today = Date()

        if let fromDate = fromDate {
            if fromDate > today {
                let relativeDate = fromDate.asRelativeDateIfPossible()
                return "Initiative starts \(relativeDate)"
            }
        }

        if let thruDate = thruDate {
            let relativeDate = thruDate.asRelativeDateIfPossible()
            if thruDate < today {
                return "Initiative ended \(relativeDate)"
            } else {
                return "Initiative ends \(relativeDate)"
            }
        }

        return "Initiative is active"
    }

    public var isEnded: Bool { thruDate ?? Date() < Date() }
    public var isFuture: Bool { fromDate ?? Date() > Date() }
}

extension RetailInitiative {
    public class RetailInitiativeItem: Identifiable, Codable {
        public var id = UUID()
        public var description: String = ""
        public var sequence: Int = 0

        init(description: String, sequence: Int) {
            self.description = description
            self.sequence = sequence
        }
    }

    public class Section: Identifiable, Codable {
        public var id = UUID()
        public var description: String
        public var sequence: Int
        public var items: [RetailInitiativeItem]

        public init(description: String, sequence: Int) {
            self.description = description
            self.sequence = sequence
            items = []
        }
    }

    public class DocumentLink: RetailInitiativeItem {
        public let documentURL: URL

        public init(description: String, sequence: Int, documentURL: URL) {
            self.documentURL = documentURL

            super.init(description: description, sequence: sequence)
        }

        enum CodingKeys: CodingKey {
            case documentURL
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            documentURL = try container.decode(URL.self, forKey: .documentURL)

            try super.init(from: decoder)
        }
    }

    public class IonReport: RetailInitiativeItem {
        var ionLayoutNid: Int
        var dxFormatNid: Int

        init(description: String, sequence: Int, ionLayoutNid: Int, dxFormatNid: Int) {
            self.ionLayoutNid = ionLayoutNid
            self.dxFormatNid = dxFormatNid

            super.init(description: description, sequence: sequence)
        }

        enum CodingKeys: CodingKey {
            case ionLayoutNid
            case dxFormatNid
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            ionLayoutNid = try container.decode(Int.self, forKey: .ionLayoutNid)
            dxFormatNid = try container.decode(Int.self, forKey: .dxFormatNid)

            try super.init(from: decoder)
        }
    }

    public class Objective: RetailInitiativeItem {
        public var objectiveTypeNid: Int?
        public var supNid: Int?
        public var startDate: Date?
        public var dueByDate: Date?
        public var sqlDescription: String?

        public init(description: String, sequence: Int, objectiveTypeNid: Int?, supNid: Int?, startDate: Date?, dueByDate: Date?, sqlDescription: String) {
            self.objectiveTypeNid = objectiveTypeNid
            self.supNid = supNid
            self.startDate = startDate
            self.dueByDate = dueByDate
            self.sqlDescription = sqlDescription

            super.init(description: description, sequence: sequence)
        }

        enum CodingKeys: CodingKey {
            case objectiveTypeNid
            case supNid
            case startDate
            case dueByDate
            case sqlDescription
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            objectiveTypeNid = try container.decode(Int.self, forKey: .objectiveTypeNid)
            supNid = try container.decode(Int.self, forKey: .supNid)
            startDate = try container.decode(Date?.self, forKey: .startDate)
            dueByDate = try container.decode(Date?.self, forKey: .dueByDate)
            sqlDescription = try container.decode(String?.self, forKey: .sqlDescription)

            try super.init(from: decoder)
        }

        public func getDateDescription() -> String {
            let today = Date()

            if let fromDate = startDate {
                if fromDate > today {
                    let relativeDate = fromDate.asRelativeDateIfPossible()
                    return "Objective starts \(relativeDate)"
                }
            }

            if let thruDate = dueByDate {
                let relativeDate = thruDate.asRelativeDateIfPossible()
                if thruDate < today {
                    return "Objective ended \(relativeDate)"
                } else {
                    return "Objective ends \(relativeDate)"
                }
            }

            return "Objective is active"
        }

        public var isEnded: Bool { dueByDate ?? Date() < Date() }
        public var isFuture: Bool { startDate ?? Date() > Date() }
    }
}
