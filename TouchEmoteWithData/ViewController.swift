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

class ViewController: NSViewController {

    var emotions: [NSManagedObject] = []
    
    @IBOutlet weak var averageEmoji: NSTextField!
    
    //No IBOutletCollection functionality for OSX apps?
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
    //can also do NSTextField.constraints[0].constant
    
    var UIDict: [String: (NSTextField, NSLayoutConstraint)] = [:]
    var emotionDict: [String: NSManagedObject] = [:]
    var labels: [NSTextField]?
    let emojis = "😔☹️😕😐🙂😀😁"
    let maxBarHeight = 290 as Float
    
    @IBOutlet weak var barTest: NSTextField!
    @IBAction func emojiButtonHandler(_ sender: NSButton) {
        storeClick(emoji: sender.title)
    }
    
    /* View Did Load */
    override func viewDidLoad() {
        super.viewDidLoad()
        if CDHelper.coreIsEmpty() {
            CDHelper.initializeCoreData()
        }
        loadEmotions() 
        buildUIDict()
        updateUI()
    }
    
    /* Update UI with count and bar heights from Emotion Dict */
    func updateUI() {
        var maxCount = 0
        var totalWeight = 0
        var totalCount = 0
        var counts: [String: Int] = [:]
        var i = 1
        /* Set counts and store max count and avg total */
        for char in emojis.characters {
            let emoji = String(char)
            let emotion = emotionDict[emoji]
            let count = emotion?.value(forKey: EmotionAttr.Count) as! Int
            totalWeight += i * count
            totalCount += count
            i += 1
            if count > maxCount {
                maxCount = count
            }
            counts[emoji] = count
            UIDict[emoji]?.0.stringValue = "\(count)"
        }
        /* Set bar heights */
        for char in emojis.characters {
            let emoji = String(char)
            let count = counts[emoji]! as Int
            let tuple = UIDict[emoji]!
            let bar: NSLayoutConstraint = tuple.1
            let height = CGFloat((Float(count) / Float(maxCount)) * maxBarHeight)
            bar.constant = height
        }
        
        /* Update Average */
        let average = Int(round(Double(totalWeight) / Double(totalCount)))
        let index = emojis.index(emojis.startIndex, offsetBy: average - 1)
        averageEmoji.stringValue = String(emojis[index])
        
    }
    
    /* Stores a click in core data */
    func storeClick(emoji: String) {
        let context = CDHelper.getContext()
        let emotion = emotionDict[emoji]! as NSManagedObject
        let currCount = emotion.value(forKey: EmotionAttr.Count) as! Int
        emotion.setValue(currCount + 1, forKey: EmotionAttr.Count)
        let clickEntity =  NSEntityDescription.entity(forEntityName: Entity.Click, in:context)
        let click = NSManagedObject(entity: clickEntity!, insertInto: context)
        click.setValue(NSDate(), forKey: ClickAttr.Time)
        click.setValue(emotion, forKey: ClickAttr.Emotion)
        CDHelper.saveContext(context: context)
        updateUI()
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
    
    /* Loads Emotions to Dict */
    func loadEmotions() {
        let emotionList: [NSManagedObject] = CDHelper.fetchDataByType(entityName: Entity.Emotion)
        for emotion in emotionList {
            emotionDict[emotion.value(forKey: EmotionAttr.Emoji) as! String] = emotion
        }
    }
    
    /* Returns touch bar to WindowController */
    @available(OSX 10.12.2, *)
    func getTouch() -> NSTouchBar {
        return touchBar!
    }

}

