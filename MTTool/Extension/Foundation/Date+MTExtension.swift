//
// Date+MTExtension.swift
//
// 日期：2018/9/13.
// 作者：Nolan   

import Foundation

extension Date {
    public var year: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.year, from: self)
    }
    
    public var month: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.month, from: self)
    }
    
    public var day: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.day, from: self)
    }
    
    public var hour: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.hour, from: self)
    }
    
    public var minute: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.minute, from: self)
    }
    
    public var second: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.second, from: self)
    }
    
    public var weekday: Int {
        let currentCalendar = Calendar.current
        return currentCalendar.component(Calendar.Component.weekday, from: self)
    }
}
