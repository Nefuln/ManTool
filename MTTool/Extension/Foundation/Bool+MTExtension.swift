// Bool+MTExtension.swift

// 日期：2018/7/3.
// 作者：Nolan   

import Foundation

extension Bool {
    
    /// 转换为Int
    public var toInt: Int { return self ? 1 : 0 }
    
    /// 反转值
    public var toggled: Bool {
        return !self
    }
    
    ///  将值反转
    @discardableResult // 不用返回值不报警告⚠️
    public mutating func invert() -> Bool {
        self = !self
        return self
    }
}
