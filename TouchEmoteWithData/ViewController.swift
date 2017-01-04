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
    @IBOutlet weak var emojiCounts: NSTextField!
    @IBOutlet weak var emojiDisplay: NSTextField!
    
    @IBAction func buttonHandler(_ sender: NSButton) {
        storeClick(emoji: sender.title)
    }
    
    /* VIEW DID LOAD */
    override func viewDidLoad() {
        super.viewDidLoad()
        emotions = CDHelper.fetchDataByType(entityName: Entity.Emotion)
        if emotions.count == 0 {
            CDHelper.initializeCoreData()
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    /* Stores a click in core data */
    //TODO: Emotions var as hashmap by emoji if possible
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
    
    /* Returns touch bar to WindowController */
    @available(OSX 10.12.2, *)
    func getTouch() -> NSTouchBar {
        return touchBar!
    }
    
    /* Returns clicks on specified emotion */
    func getClicks(emotion: NSManagedObject) -> [NSManagedObject] {
        let clicks = emotion.value(forKey: EmotionAttr.Clicks) as! NSOrderedSet
        return clicks.array as! [NSManagedObject]
    }

}

