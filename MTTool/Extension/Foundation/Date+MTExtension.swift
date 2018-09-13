//
// Date+MTExtension.swift
//
// 日期：2018/9/13.
// 作者：Nolan   

import Foundation

extension Date {
    public var localDescription: String {
        return self.descriptionByDateFormatter()
    }
    
    public func descriptionByDateFormatter(formatter: String = "yyyy:MM:dd hh:mm:ss") -> String {
        let timeZone = TimeZone.current
        return ""
    }
}

extension Date {
    
    /// 时间组件，可以各取所需
    public var com: DateComponents {
        let currentCalendar = Calendar.current
        return currentCalendar.dateComponents([.era,                    // 区域
                                               .year,                   // 年份
                                               .quarter,                // 季度
                                               .month,                  // 月份
                                               .day,                    // 日期
                                               .hour,                   // 小时
                                               .minute,                 // 分钟
                                               .second,                 // 秒
                                               .nanosecond,             // 纳秒
                                               .weekday,                // 周几
                                               .weekdayOrdinal,         // 以当月的第一天座位第一周算出来的周数
                                               .weekOfMonth,            // 当月中的第几周
                                               .weekOfYear,             // 当年中的第几周
                                               .yearForWeekOfYear,      // 每年的最后或最开始的几天根据iso8640标准属于的年份
                                               .calendar,               // 日历
                                               .timeZone], from: self)  // 时区
    }
    
    /// 年份
    public var year: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.year, from: self)
    }
    
    /// 季度
    public var quarter: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.quarter, from: self)
    }
    
    /// 月份
    public var month: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.month, from: self)
    }
    
    /// 日期
    public var day: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.day, from: self)
    }
    
    /// 小时
    public var hour: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.hour, from: self)
    }
    
    /// 分钟
    public var minute: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.minute, from: self)
    }
    
    /// 秒
    public var second: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.second, from: self)
    }
    
    /// 周几
    public var weekday: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.weekday, from: self)
    }
}
