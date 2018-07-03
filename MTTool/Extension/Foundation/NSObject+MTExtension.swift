// NSObject+MTExtension.swift

// 日期：2018/7/3.
// 作者：Nolan   

import Foundation

extension NSObject {
    public var className: String {
        return type(of: self).className
    }
    
    public static var className: String {
        return String(describing: self)
    }
}
