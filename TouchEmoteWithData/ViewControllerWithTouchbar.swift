//
//  ViewControllerWithTouchbar.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/6/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Cocoa

class ViewControllerWithTouchbar: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @available(OSX 10.12.2, *)
    func getTouch() -> NSTouchBar {
        return NSTouchBar()
    }
    
}
