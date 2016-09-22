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
extension Timer{
    public class func LCD_scheduledTimerWithTimeInterval(time:TimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> Timer{
        let lcdtime = self.scheduledTimer(timeInterval: time, target: self, selector:#selector(Timer.excuteTimerClosure), userInfo: unsafeBitCast(closure, to: AnyObject.self), repeats: yesOrNo)
        RunLoop.current.add(lcdtime, forMode: .commonModes)
        return lcdtime
        
    }
    class func excuteTimerClosure(timer: Timer)
    {
        let closure = unsafeBitCast(timer.userInfo, to: TimerExcuteClosure.self)
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
//MARK:---------- UIPageControl
extension UIPageControl {
    enum PageControlAlignmentType {
        case Left
        case Right
        case Center
    }
    //设置分页圆点的位置
    func alignment(type:PageControlAlignmentType, pageCount:Int, sizeW:CGFloat){
        //小圆点个数
        let page_w: CGFloat = self.size(forNumberOfPages: pageCount).width + 20
        switch type {
        case .Left:
            self.frame.size.width = page_w
        case .Right:
            print(self.frame.size.width)
            let page_x:CGFloat = sizeW - page_w
            self.frame.origin.x = page_x
            self.frame.size.width = page_w
        case .Center:break
        }
    }
}

