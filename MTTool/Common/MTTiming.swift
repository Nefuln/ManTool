//
// MTTiming.swift
//
// 日期：2018/9/13.
// 作者：Nolan   

import UIKit

class MTTiming: NSObject {
    
    /// 获取系统启动的累积时间，包含休眠时间，主要用于时间校准
    static var systemUpTime: TimeInterval {
        return ProcessInfo.processInfo.systemUptime
    }
    
    /// 获取系统启动之后的运行总时间，不包括休眠时间，主要用于计算代码执行效率
    static var currentTimeClick: UInt64 {
        return mach_absolute_time()
    }
    
    /// 获取代码块执行时间
    ///
    /// - Parameter block: 代码块
    /// - Returns: 传入的代码块执行总时间，单位：纳秒
    static func executeTime(_ block: (()->Void)?) -> UInt64 {
        if block == nil {
            return 0
        }
        
        var info = mach_timebase_info()
        if mach_timebase_info(&info) != KERN_SUCCESS {
            return 0
        }
        let start = self.currentTimeClick
        block?()
        let end = self.currentTimeClick
        let duration = end - start
        let nanos = duration * UInt64(info.numer) / UInt64(info.denom)
        return nanos
    }
    
}
