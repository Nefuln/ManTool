// NSObject+MTExtension.swift

// 日期：2018/7/3.
// 作者：Nolan   

import Foundation

extension NSObject {
    
    /// 类名称（不带命名空间的前缀）
    public var className: String {
        return type(of: self).className
    }
    
    /// 类名称（不带命名空间的前缀）
    public static var className: String {
        return String(describing: self)
    }
}
