//
// CGFloat+MTExtension.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import UIKit

extension CGFloat {
    
    /// 生成一个0~1.0之间的随机数
    ///
    /// - Returns: 0~1.0之间的随机数
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    /// 生成一个指定区间的随机数
    ///
    /// - Parameter within: 指定区间
    /// - Returns: 指定区间的随机数
    public static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /// 生成一个指定区间的随机数
    ///
    /// - Parameter within: 指定区间
    /// - Returns: 指定区间的随机数
    public static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
}
