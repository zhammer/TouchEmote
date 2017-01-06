//
//  DateHelper.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/5/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Foundation
import Cocoa

struct Comp {
    static let Less = -1
    static let Equal = 0
    static let Greater = 1
}

class DateHelper {
    
    /* Compares two Dates and returns if date1 is Less than, Equal to, or Greater than date2 */
    // Change language to after / before
    // Maybe use Date.timeIntervalSince1970
    static func dateCompare(date1: Date, date2: Date) -> Int {
        if date1.compare(date2) == ComparisonResult.orderedDescending {
            return Comp.Greater
        } else if date1.compare(date2) == ComparisonResult.orderedAscending {
            return Comp.Less
        } else {
            return Comp.Equal
        }
    }
    
    /* Returns true if date occurs after toCompare */
    static func hasPassedDate(date: Date) -> Bool {
        if dateCompare(date1: Date(), date2: date) == Comp.Greater {
            return true
        }
        return false
    }
    
    /* Shifts an Date by month, week and day delta values */
    static func shiftDate(date: Date, monthDelta: Int = 0, weekDelta: Int = 0, dayDelta: Int = 0) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = monthDelta
        components.weekOfYear = weekDelta
        components.day = dayDelta
        return calendar.date(byAdding: components, to: date)!
    }
    
    /* Returns Date one week previous to input Date */
    static func prevWeek(date: Date) -> Date {
        return shiftDate(date: date, weekDelta: -1)
    }
    
    /* Returns Date one month previous to input Date */
    static func prevMonth(date: Date) -> Date {
        return shiftDate(date: date, monthDelta: -1)
    }
    
    /* Returns Date one month after input Date */
    static func nextDay(date: Date) -> Date {
        return shiftDate(date: date, dayDelta: 1)
    }
    
    /* Returns start of day */
    static func dayStart() -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
}
