//
//  LogViewController.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/6/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import Cocoa

class LogViewController: ViewControllerWithTouchbar {
    
    @IBOutlet weak var mainText: NSTextField!

    @IBAction func emojiButtonHandler(_ sender: NSButton) {
        let emoji = sender.title
        CDHelper.storeClick(emoji: emoji)
        mainText.stringValue = emoji
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @available(OSX 10.12.2, *)
    override func getTouch() -> NSTouchBar {
        print("\(touchBar!)")
        return touchBar!
    }
    
}
