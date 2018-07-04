//
// UserDefault+MTExtension.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import Foundation

extension UserDefaults {
    
    /// 支持使用语法糖
    ///
    /// - Parameter key: key
    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key) as Any?
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    /// 支持日期返回
    ///
    /// - Parameter key: key
    /// - Returns: 日期
    public func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
}
