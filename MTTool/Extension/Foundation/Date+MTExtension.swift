//
// Date+MTExtension.swift
//
// 日期：2018/9/13.
// 作者：Nolan   

import Foundation

extension Date {
    
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
