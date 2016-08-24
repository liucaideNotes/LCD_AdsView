//
//  LCDAdsViewExtension.swift
//  LCD_AdsView
//
//  Created by 刘才德 on 16/8/22.
//  Copyright © 2016年 sifenzi. All rights reserved.
//

import Foundation
import UIKit




//MARK:---------- NSTimer
public typealias TimerExcuteClosure = @convention(block)()->()
extension NSTimer{
    public class func LCD_scheduledTimerWithTimeInterval(time:NSTimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> NSTimer{
        let lcdtime = self.scheduledTimerWithTimeInterval(time, target: self, selector: #selector(NSTimer.excuteTimerClosure(_:)), userInfo: unsafeBitCast(closure, AnyObject.self), repeats: yesOrNo)
        NSRunLoop.currentRunLoop().addTimer(lcdtime, forMode: NSRunLoopCommonModes)
        return lcdtime
        
    }
    class func excuteTimerClosure(timer: NSTimer)
    {
        let closure = unsafeBitCast(timer.userInfo, TimerExcuteClosure.self)
        closure()
    }
}
//MARK:---------- UIColor
extension UIColor {
    
    class func xzTintColor1() -> UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1)
    }
    
    class func xzTintColor2() -> UIColor {
        return UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.6)
    }
}
