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
    
    @IBOutlet weak var button_0: NSButton!
    @IBOutlet weak var button_1: NSButton!
    @IBOutlet weak var button_2: NSButton!
    @IBOutlet weak var button_3: NSButton!
    @IBOutlet weak var button_4: NSButton!
    @IBOutlet weak var button_5: NSButton!
    @IBOutlet weak var button_6: NSButton!
    var buttonList: [NSButton] = []
    
    
    @IBAction func emojiButtonHandler(_ sender: NSButton) {
        let emoji = sender.title
        CDHelper.storeClick(emoji: emoji)
        mainText.stringValue = emoji
        mainText.font = NSFont(name: "Arial", size: 120)
        AnimationHelper.fadeIn(component: mainText)
        lockOtherButtons(pressed: sender)
    }
    
    func lockOtherButtons(pressed: NSButton) {
        //TODO?: Button mods & locking after press
        for button in buttonList {
            button.isEnabled = false
            // Mods for selected button
            if button.isEqual(pressed) {
            }
            // Mods for not selected buttons
            else {
                AnimationHelper.fadeOut(component: button, toAlpha: 0.5)
            }
        }
    }
    
    func buildButtonList() {
        buttonList = [
            button_0,
            button_1,
            button_2,
            button_3,
            button_4,
            button_5,
            button_6
        ]
    }
    
    override func viewWillAppear() {
        AnimationHelper.fadeIn(component: mainText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildButtonList()
    }
    
    
    @available(OSX 10.12.2, *)
    override func getTouch() -> NSTouchBar {
        return touchBar!
    }
    
}
