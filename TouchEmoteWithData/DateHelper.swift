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
    
    /* Compares two NSDates and returns if date1 is Less than, Equal to, or Greater than date2 */
    static func dateCompare(date1: NSDate, date2: NSDate) -> Int {
        if date1.compare(date2 as Date) == ComparisonResult.orderedDescending {
            return Comp.Greater
        } else if date1.compare(date2 as Date) == ComparisonResult.orderedAscending {
            return Comp.Less
        } else {
            return Comp.Equal
        }
    }
    
    /* Shifts an NSDate by month, week and day delta values */
    static func shiftDate(date: NSDate, monthDelta: Int = 0, weekDelta: Int = 0, dayDelta: Int = 0) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as NSCalendar
        let components = NSDateComponents()
        components.month = monthDelta
        components.weekOfYear = weekDelta
        components.day = dayDelta
        return calendar.date(byAdding: components as DateComponents, to: date as Date)! as NSDate
    }
    
    /* Returns NSDate one week previous to input NSDate */
    static func prevWeek(date: NSDate) -> NSDate {
        return shiftDate(date: date, weekDelta: -1)
    }
    
    /* Returns NSDate one month previous to input NSDate */
    static func prevMonth(date: NSDate) -> NSDate {
        return shiftDate(date: date, monthDelta: -1)
    }
    
    /* Returns NSDate one month after input NSDate */
    static func nextDay(date: NSDate) -> NSDate {
        return shiftDate(date: date, dayDelta: 1)
    }
    
    /* Returns start of day */
    static func dayStart() -> NSDate {
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as NSCalendar
        let components = NSDateComponents()
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.date(byAdding: components as DateComponents, to: date as Date)! as NSDate
    }
    
}
