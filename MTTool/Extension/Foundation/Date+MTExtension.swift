//
// Date+MTExtension.swift
//
// 日期：2018/9/13.
// 作者：Nolan   

import Foundation

extension Date {
    
    /// 是否是闰年
    public var isLeapYear: Bool {
        return (self.year % 4 == 0 && self.year % 100 != 0) || (self.year % 400 == 0)
    }
    
    /// 当月的天数
    public var daysOfMonth: Int {
        switch self.month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 2:
            return self.isLeapYear ? 29 : 28
        default:
            return 30
        }
    }
    
    /// 本地描述字符串
    public var localDescription: String {
        return self.descriptionByDateFormatter()
    }
    
    /// 格式化日期字符串
    ///
    /// - Parameter formatter: 字符串格式
    /// - Returns: 格式化后的日期字符串
    public func descriptionByDateFormatter(formatter: String = "yyyy:MM:dd hh:mm:ss") -> String {
        let timeZone = TimeZone.current
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
    
    /// 格式化日期字符串
    /// 注：基于`DateFormatter`创建比较耗时，必要时可以定制标准的DateFormatter作为单例
    ///
    /// - Parameter dateFormatter: 日期格式
    /// - Returns: 格式化后的日期字符串
    public func descriptionByDateFormatter(dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
    
    /// 根据日期字符串和字符串格式生成日期
    ///
    /// - Parameters:
    ///   - dateStr: 日期字符串
    ///   - formatter: 日期字符串格式，必须和字符串格式对应，否则返回nil
    /// - Returns: Date
    static func date(from dateStr: String, formatter: String = "yyyy:MM:dd hh:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from: dateStr)
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
