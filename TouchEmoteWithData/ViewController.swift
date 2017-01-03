//
//  ViewController.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/2/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Cocoa
import CoreData

struct CDEntity {
    static let Emotion = "Emotion"
    static let Click = "Click"
}

struct CDAttribute {
    static let Emoji = "emoji"
    static let Count = "count"
}

class ViewController: NSViewController {

    var emotions: [NSManagedObject] = []
    let emojis: String = "😁😀🙂😐😕☹️😔"
    @IBOutlet weak var emojiCounts: NSTextField!
    @IBOutlet weak var emojiDisplay: NSTextField!
    
    @IBAction func buttonHandler(_ sender: NSButton) {
        let emoji = sender.title
        storeClick(emoji: emoji)
        emojiDisplay.stringValue = emoji
        updateDisplay()
    }
    
    /* VIEW DID LOAD */
    override func viewDidLoad() {
        super.viewDidLoad()
        if !getCoreData() {
            initializeCoreData()
        }
        updateDisplay()
//        clearCoreData()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @available(OSX 10.12.2, *)
    func getTouch() -> NSTouchBar {
        return touchBar!
    }
    
    
    func updateDisplay() {
        var newText = ""
        getCoreData()
        for emotion in emotions {
            let emoji:String = emotion.value(forKey: CDAttribute.Emoji) as! String
            let count:Int = emotion.value(forKey: CDAttribute.Count) as! Int
            newText += "\(emoji): \(count)\n"
        }
        emojiCounts.stringValue = newText
    }
    
    /* Stores a click in core data */
    func storeClick(emoji: String) {
//        let context = getContext()
//        let entity =  NSEntityDescription.entity(forEntityName: CDEntity.Emotion, in: context)
//        let emotion = NSManagedObject(entity: entity!, insertInto: context)
//        emotion.setValue(emoji, forKey: CDAttribute.Emoji)
        for emotion in emotions {
            if emotion.value(forKey: CDAttribute.Emoji) as! String == emoji {
                let currCount = emotion.value(forKey: CDAttribute.Count) as! Int
                emotion.setValue(currCount + 1, forKey: CDAttribute.Count)
            }
        }
        do {
            try getContext().save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    /* Fetches core data. Returns false if core data is empty */
    @discardableResult func getCoreData() -> Bool {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CDEntity.Emotion)
        do {
            let results = try context.fetch(fetchRequest)
            emotions = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return emotions.count > 0
    }
    
    /* Initializes core data on app's first run. */
    func initializeCoreData() {
        let context = getContext()
        let entity =  NSEntityDescription.entity(forEntityName: CDEntity.Emotion, in:context)
        
        //Create Emotion entity for each emoji character
        for emoji in emojis.characters {
            let emotion = NSManagedObject(entity: entity!, insertInto: context)
            emotion.setValue(String(emoji), forKey: CDAttribute.Emoji)
            do {
                try context.save()
                emotions.append(emotion)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        print("Initialized new data set")
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }
    
    func getPSC () -> NSPersistentStoreCoordinator {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        return appDelegate.persistentStoreCoordinator
    }
    
    func clearCoreData() {
        let context = getContext()
        for emotion in emotions {
            context.delete(emotion)
        }
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }



}

