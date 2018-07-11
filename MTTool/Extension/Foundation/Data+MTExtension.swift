//
// Data+MTExtension.swift
//
// 日期：2018/7/11.
// 作者：Nolan   

import Foundation

extension Data {
    public var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    /// 获取某个不可数的开区间的字符串
    ///
    /// - Parameter integerRange: 1..<2
    public subscript(integerRange: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = self.index(startIndex, offsetBy: integerRange.upperBound)
        return self[start..<end]
    }
    
    /// 获取某个不可数的闭区间的字符串
    ///
    /// - Parameter integerRange: 1...2
    public subscript(integerClosedRange: ClosedRange<Int>) -> String {
        return self[integerClosedRange.lowerBound..<(integerClosedRange.upperBound + 1)]
    }
}
