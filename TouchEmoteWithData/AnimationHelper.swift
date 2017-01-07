//
//  AnimationHelper.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/6/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Foundation
import Cocoa

class AnimationHelper {
    
    static func fadeIn(component: NSControl, duration: Int = 2) {
        component.alphaValue = 0
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = TimeInterval(duration)
            component.animator().alphaValue = 1
        })
    }
    
    static func growHeight(component: NSControl, duration: Int = 2) {
        component
    }
    
}
