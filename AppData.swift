//
//  AppData.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/3/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Foundation
import Cocoa


class AppData {
    var dict: [String: Int] = [:]
    var cdHasUpdated: Bool = false
    var max = 0
    let emojis = "😁😀🙂😐😕☹️😔"
    
    init() {
        for emoji in emojis.characters {
            dict[String(emoji)] = 0
        }
    }
    
    /* Returns tuple of (emoji count map, max emoji count) */
    func getData() -> ([String: Int], Int) {
        if cdHasUpdated {
            updateData()
        }
        return (dict, max)
    }
    
    private func updateData() {
        let emotions: [NSManagedObject] = CDHelper.fetchDataByType(entityName: Entity.Emotion)
        for emotion in emotions {
            let count = emotion.value(forKey: EmotionAttr.Count) as! Int
            if count > max {
                max = count
            }
            let emoji = emotion.value(forKey: EmotionAttr.Emoji) as! String
            dict[emoji] = count
        }
    }

    
    
    
    
    
}
