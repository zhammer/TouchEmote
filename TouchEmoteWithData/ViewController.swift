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
    
    var UIDict: [String: (NSTextField, NSLayoutConstraint)] = [:]
    //TODO: Build emotion dict
    var emotionDict: [String: NSManagedObject] = [:]
    
    
    var labels: [NSTextField]?
    
    @IBAction func emojiButtonHandler(_ sender: NSButton) {
        storeClick(emoji: sender.title)
    }
    
    /* Initializer */
    override func viewDidLoad() {
        super.viewDidLoad()
        emotions = CDHelper.fetchDataByType(entityName: Entity.Emotion)
        if emotions.count == 0 {
            CDHelper.initializeCoreData()
        }
    }

    
    /* Stores a click in core data */
    func storeClick(emoji: String) {
        let context = CDHelper.getContext()
        for emotion in emotions {
            if emotion.value(forKey: EmotionAttr.Emoji) as! String == emoji {
                let currCount = emotion.value(forKey: EmotionAttr.Count) as! Int
                emotion.setValue(currCount + 1, forKey: EmotionAttr.Count)
                let clickEntity =  NSEntityDescription.entity(forEntityName: Entity.Click, in:context)
                let click = NSManagedObject(entity: clickEntity!, insertInto: context)
                click.setValue(NSDate(), forKey: ClickAttr.Time)
                click.setValue(emotion, forKey: ClickAttr.Emotion)
            }
        }
        CDHelper.saveContext(context: context)
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
    func getTouch() -> NSTouchBar {
        return touchBar!
    }

}

