//
//  CDHelper.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/3/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Foundation
import Cocoa
import CoreData

class CDHelper {
    
    /* Initializes core data on app's first run. */
    static func initializeCoreData() {
        let context = getContext()
        assert(fetchDataByType(entityName: Entity.Emotion).count == 0, "Core data already initialized.")
        let entity =  NSEntityDescription.entity(forEntityName: Entity.Emotion, in:context)
        for emoji in "😁😀🙂😐😕☹️😔".characters {
            let emotion = NSManagedObject(entity: entity!, insertInto: context)
            emotion.setValue(String(emoji), forKey: EmotionAttr.Emoji)
        }
        saveContext(context: context)
        print("Initialized new data set")
    }
    
    /* Deletes all objects from Core Data */
    static func clearCoreData() {
        let context = getContext()
        let emotions: [NSManagedObject] = fetchDataByType(entityName: Entity.Emotion)
        let clicks : [NSManagedObject] = fetchDataByType(entityName: Entity.Click)
        for emotion in emotions {
            context.delete(emotion)
        }
        for click in clicks {
            context.delete(click)
        }
        saveContext(context: context)
    }
    
    /* Fetches data of Entity specified by name. Returns results as [NSManagedObject] */
    static func fetchDataByType(entityName: String) -> [NSManagedObject] {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var output: [NSManagedObject] = []
        do {
            let results = try context.fetch(fetchRequest)
            output = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return output
    }
    
    /* Returns clicks on specified emotion */
    static func getClicks(emotion: NSManagedObject) -> [NSManagedObject] {
        let clicks = emotion.value(forKey: EmotionAttr.Clicks) as! NSOrderedSet
        return clicks.array as! [NSManagedObject]
    }

    /* Returns NSManagedObjectContext reference from AppDelegate */
    static func getContext () -> NSManagedObjectContext {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }
    
    /* Saves NSManagedOBjectContext */
    static func saveContext (context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
