//
//  ViewController.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/2/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Cocoa
import CoreData

struct Entity {
    static let Emotion = "Emotion"
    static let Click = "Click"
}

struct EmotionAttr {
    static let Emoji = "emoji"
    static let Count = "count"
    static let Clicks = "clicks"
}

struct ClickAttr {
    static let Time = "timestamp"
    static let Emotion = "emotion"
}

struct TimeRange {
    static let Day = "day"
    static let Week = "week"
    static let Month = "month"
}

//TODO: struct for timestamps
//TimeStart.Day TimeStart.Week TimeStart.Month

class ViewController: ViewControllerWithTouchbar {
    
    @IBOutlet weak var averageEmoji: NSTextField!
    @IBOutlet weak var timeRangeLabel: NSTextField!
    
    /* No IBOutletCollection functionality for MacOS */
    @IBOutlet weak var count_0: NSTextField!
    @IBOutlet weak var count_1: NSTextField!
    @IBOutlet weak var count_2: NSTextField!
    @IBOutlet weak var count_3: NSTextField!
    @IBOutlet weak var count_4: NSTextField!
    @IBOutlet weak var count_5: NSTextField!
    @IBOutlet weak var count_6: NSTextField!
    
    @IBOutlet weak var bar_0: NSLayoutConstraint!
    @IBOutlet weak var bar_1: NSLayoutConstraint!
    @IBOutlet weak var bar_2: NSLayoutConstraint!
    @IBOutlet weak var bar_3: NSLayoutConstraint!
    @IBOutlet weak var bar_4: NSLayoutConstraint!
    @IBOutlet weak var bar_5: NSLayoutConstraint!
    @IBOutlet weak var bar_6: NSLayoutConstraint!
    
    var UIDict: [String: (NSTextField, NSLayoutConstraint)] = [:]
    let emojis = "😔☹️😕😐🙂😀😁"
    let maxBarHeight = 290 as Float
    
    var dayCurr: Date?
    var dayNext: Date?
    var currTimeRange = TimeRange.Day
    var countsDay: [String: Int] = [:]
    var countsWeek: [String: Int] = [:]
    var countsMonth: [String: Int] = [:]
    
    /* Updates currTimeRange and reloads UI */
    @IBAction func timeRangeButtonHandler(_ sender: NSButton) {
        currTimeRange = sender.alternateTitle
        updateUI()
    }
    
    /* Initializes DB and UI */
    override func viewWillAppear() {
        super.viewWillAppear()
        if CDHelper.coreIsEmpty() {
            CDHelper.initializeCoreData()
        }
        buildUIDict()
        updateUI()
    }
    
    /* View Did Load */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* Updates UI with count and bar heights from Emotion Dict */
    func updateUI() {
        updateDay()
        var maxCount = 0
        var totalWeight = 0
        var totalCount = 0
        var counts: [String: Int] = [:]
        if currTimeRange == TimeRange.Day {
            timeRangeLabel.stringValue = "Today:"
            counts = countsDay
        } else if currTimeRange == TimeRange.Week {
            counts = countsWeek
            timeRangeLabel.stringValue = "This Week:"
        } else if currTimeRange == TimeRange.Month {
            counts = countsMonth
            timeRangeLabel.stringValue = "This Month:"
        }
        
        // Finds max count and total count values for averaging/UI
        var i = 1
        for char in emojis.characters {
            let emoji = String(char)
            let count = counts[emoji]!
            totalWeight += i * count
            totalCount += count
            if count > maxCount {
                maxCount = count
            }
            i += 1
        }
        
        // Sets bar heights and counter strings
        for char in emojis.characters {
            let emoji = String(char)
            let count = counts[emoji]! as Int
            let height = CGFloat((Float(count) / Float(maxCount)) * maxBarHeight)
            UIDict[emoji]?.0.stringValue = "\(count)"
            UIDict[emoji]?.1.constant = height
        }
        
        // Updates average emoji
        let average = Int(round(Double(totalWeight) / Double(totalCount)))
        let index = emojis.index(emojis.startIndex, offsetBy: average - 1)
        averageEmoji.stringValue = String(emojis[index])
    }
    
    /* Checks and updates current day start. If day has changed, reloads click counters */
    func updateDay() {
        if dayCurr == nil || DateHelper.hasPassedDate(date: dayNext!) {
            dayCurr = DateHelper.dayStart()
            dayNext = DateHelper.nextDay(date: dayCurr!)
            loadClickCounts()
        }
    }
    
    /* Saves click counts on each emotion in three time ranges in memory */
    func loadClickCounts() {
        let dayMark: Date = dayCurr!
        let weekMark: Date = DateHelper.prevWeek(date: dayMark)
        let monthMark: Date = DateHelper.prevMonth(date: dayMark)
        //TODO: store count as 0 if nil=
        for char in emojis.characters {
            let emoji = String(char)
            countsDay[emoji] = CDHelper.getClicks(emoji: emoji, afterDate:  dayMark).count
            countsWeek[emoji] = CDHelper.getClicks(emoji: emoji, afterDate: weekMark).count
            countsMonth[emoji] = CDHelper.getClicks(emoji: emoji, afterDate: monthMark).count
        }
    }

    /* Builds UI Dictionary */
    func buildUIDict() {
        UIDict["😔"] = (count_0, bar_0)
        UIDict["☹️"] = (count_1, bar_1)
        UIDict["😕"] = (count_2, bar_2)
        UIDict["😐"] = (count_3, bar_3)
        UIDict["🙂"] = (count_4, bar_4)
        UIDict["😀"] = (count_5, bar_5)
        UIDict["😁"] = (count_6, bar_6)
    }
    
    /* Returns touch bar to WindowController */
    @available(OSX 10.12.2, *)
    override func getTouch() -> NSTouchBar {
        return touchBar!
    }

}

