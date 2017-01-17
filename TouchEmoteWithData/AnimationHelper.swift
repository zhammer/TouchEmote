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
        component.alphaValue = 0 
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = TimeInterval(duration)
            component.animator().alphaValue = 1
        })
    }
    
    static func fadeOut(component: NSControl, duration: Int = 2, toAlpha: CGFloat = 1) {
        component.alphaValue = 0
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = TimeInterval(duration)
            component.animator().alphaValue = toAlpha
        })
    }
    
    static func growConstraint(constraint: NSLayoutConstraint, fromSize: CGFloat = 0, toSize: CGFloat, duration: Int = 2) {
        if fromSize == toSize {
            return
        }
        constraint.constant = fromSize
        NSAnimationContext.runAnimationGroup({ (context) in
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            context.duration = TimeInterval(duration)
            constraint.animator().constant = toSize
        })
    }
    
    static func dissolve(label: NSTextField) {
        let animation: CATransition = CATransition()
        animation.duration = 1.0
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        label.layer?.add(animation, forKey: "changeTextTransition")
    }
    
    static func count(from: Int = 0, to: Int, label: NSTextField) {
        let animation = CATransition()
        animation.isRemovedOnCompletion = true
        animation.duration = 0.2
        animation.type = kCATransitionPush
        animation.subtype = to > from ? kCATransitionFromTop : kCATransitionFromBottom
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        label.layer?.add(animation, forKey:"changeTextTransition")
    }
    
}
