//
//  ReplaceSegue.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/6/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Cocoa

class ReplaceSegue: NSStoryboardSegue {
    
    override func perform() {
        if let fromViewController = sourceController as? NSViewController {
            if let toViewController = destinationController as? NSViewController {
                // no animation.
                fromViewController.view.window?.contentViewController = toViewController
            }
        }
    }
    
}
