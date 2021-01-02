//
//  CusEvent.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/11/20.
//

import Foundation

public class CusEvent: Identifiable, Codable {
    public let id: UUID

    public enum eTask: Int, Codable {
        /// Go to the customer and enter a pre-sell order.
        case Presell = 0
        case InsideSales = 1
        /// Go to the customer and sell something from your truck.
        case OffTruck = 2
        /// Deliver a downloaded order (product is on the truck) to the customer.
        case DeliverPresoldOrder = 3
        case AlternateDeliveryDriver = 4
        /// Go to the customer (supermarket e.g.) and merchandise (refill) the shelves.
        case Merchandiser = 5
        case VendingDriver = 6
    }

    public let task: eTask
    public let monday: Bool
    public let tuesday: Bool
    public let wednesday: Bool
    public let thursday: Bool
    public let friday: Bool
    public let saturday: Bool
    public let sunday: Bool
    public let cycleLength: Int
    public let weekOfCycle: Int
    public let empNid: Int
    public let equipNid: Int?

    public init(task: eTask, monday: Bool, tuesday: Bool, wednesday: Bool, thursday: Bool, friday: Bool, saturday: Bool, sunday: Bool, cycleLength: Int, weekOfCycle: Int, empNid: Int, equipNid: Int?) {
        id = UUID()
        self.task = task
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
        self.cycleLength = cycleLength
        self.weekOfCycle = weekOfCycle
        self.empNid = empNid
        self.equipNid = equipNid
    }
}

extension CusEvent {
    static let cycleBaseDate = getCycleBaseDate()

    static func getCycleBaseDate() -> Date {
        var components = DateComponents()
        components.year = 1990
        components.month = 1
        components.day = 1
        let date = Calendar.current.date(from: components)!
        return date
    }

    /// Return the next date for this event (or nil if no days are schedule - IsActive is false)
    public func getNextScheduleDateAfter(_ date: Date) -> Date? {
        for i in 1 ... cycleLength * 7 {
            guard let futureDate = Calendar.current.date(byAdding: .day, value: i, to: date) else {
                return nil
            }

            if isScheduled(futureDate) {
                return futureDate
            }
        }

        return nil
    }

    /// Return the week of the cycle (1, 2, ... CycleLength)
    private func getWeekOfCycle(_ date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: Self.cycleBaseDate, to: date)

        let spanDays = components.day!
        let weekNumber = spanDays / 7
        let weekOfCycle = 1 + weekNumber % cycleLength

        return weekOfCycle
    }

    public func isScheduled(_ date: Date) -> Bool {
        if cycleLength > 1 {
            if weekOfCycle != getWeekOfCycle(date) {
                return false
            }
        }

        let weekday: Int = Calendar.current.component(.weekday, from: date)

        switch weekday { // https://developer.apple.com/documentation/foundation/calendar/component/weekday
        case 1: return sunday
        case 2: return monday
        case 3: return tuesday
        case 4: return wednesday
        case 5: return thursday
        case 6: return friday
        case 7: return saturday
        default: return false
        }
    }

    public var isMondayThruFriday: Bool {
        monday && tuesday && wednesday && thursday && friday && !saturday && !sunday
    }

    public var isMondayThruSaturday: Bool {
        monday && tuesday && wednesday && thursday && friday && saturday && !sunday
    }

    public var isEveryDay: Bool {
        monday && tuesday && wednesday && thursday && friday && saturday && sunday
    }

    public var firstDayForSorting: Int {
        if monday { return 1 }
        if tuesday { return 2 }
        if wednesday { return 3 }
        if thursday { return 4 }
        if friday { return 5 }
        if saturday { return 6 }
        if sunday { return 7 } // put Sunday last
        return 0
    }

    public var daysDescription: String {
        let dayNames = Calendar.current.weekdaySymbols

        var listOfScheduledDays: [String] = []
        if monday { listOfScheduledDays.append(dayNames[1]) }
        if tuesday { listOfScheduledDays.append(dayNames[2]) }
        if wednesday { listOfScheduledDays.append(dayNames[3]) }
        if thursday { listOfScheduledDays.append(dayNames[4]) }
        if friday { listOfScheduledDays.append(dayNames[5]) }
        if saturday { listOfScheduledDays.append(dayNames[6]) }
        if sunday { listOfScheduledDays.append(dayNames[0]) }
        if dayNames.count == 0 {
            return "No days scheduled"
        }

        let dayNameList: String

        if isMondayThruFriday {
            dayNameList = "\(dayNames[1]) through \(dayNames[5])"
        } else if isMondayThruSaturday {
            dayNameList = "\(dayNames[1]) through \(dayNames[6])"
        } else if isEveryDay {
            dayNameList = "\(dayNames[1]) through \(dayNames[0])"
        } else {
            dayNameList = listOfScheduledDays.joined(separator: ", ")
        }

        switch cycleLength {
        case 1:
            return "\(dayNameList)"
        case 2:
            return "Every other \(dayNameList)"
        case 3:
            return "Every 3rd \(dayNameList)"
        case 4:
            return "Every 4th \(dayNameList)"
        default:
            return "\(dayNameList) every \(cycleLength) weeks"
        }
    }

    public var taskDescription: String {
        switch task {
        case .Presell:
            return "Pre-sell"
        case .InsideSales:
            return "Inside-sales"
        case .OffTruck:
            return "Off-truck sale"
        case .DeliverPresoldOrder:
            return "Deliver"
        case .AlternateDeliveryDriver:
            return "Alternate driver"
        case .Merchandiser:
            return "Merchandise"
        case .VendingDriver:
            return "Vending service"
        }
    }
}
