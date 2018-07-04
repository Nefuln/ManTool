//
// Timer+MTExtension.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import Foundation

extension Timer {
    
    /// 间隔指定时间执行一次，取消用：timer.invalidate()
    ///
    /// - Parameters:
    ///   - seconds: 间隔时间
    ///   - handler: 执行回调
    /// - Returns: 定时器对象
    public static func runThisEvery(seconds: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    /// 指定时间后在主线程执行一次
    ///
    /// - Parameters:
    ///   - seconds: 间隔时间
    ///   - after: 执行回调
    public static func runThisAfterDelay(seconds: Double, after: @escaping () -> Void) {
        runThisAfterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }
    
    /// 指定时间后在指定线程执行一次
    ///
    /// - Parameters:
    ///   - seconds: 间隔时间
    ///   - queue: 指定线程
    ///   - after: 执行回调
    public static func runThisAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
}
