//
//  WindowController.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/2/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Foundation
import Cocoa

struct View {
    static let Log = "LogViewController"
    static let Stats = "StatsViewController"
}

class MyWindowController: NSWindowController {
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        guard let viewController = contentViewController as? ViewControllerWithTouchbar else {
            return nil
        }
        return viewController.getTouch()
    }
}
