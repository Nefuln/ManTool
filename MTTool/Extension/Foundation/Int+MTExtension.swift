//
// Int+MTExtension.swift
//
// 日期：2018/7/27.
// 作者：Nolan   

import Foundation

extension FixedWidthInteger {
    
    /// 整形值
    public var intValue: Int {
        return Int(self)
    }
    
    /// Bool值
    public var boolValue: Bool {
        return self != 0
    }
    
    /// 平方根
    public var sqrtValue: Double {
        return sqrt(Double(self))
    }
    
    /// 是否是奇数
    public var isOdd: Bool {
        return self % 2 == 1
    }
    
    /// 是否是偶数
    public var isEven: Bool {
        return !isOdd
    }
    
    /// 是否是素数或质数
    public var isPrime: Bool {
        switch self {
        case 2, 3:
            return true
        default:
            if self < 2 {
                return false
            } else if self % 6 != 1 && self % 6 != 5 { // 不在6的倍数两侧的一定不是质数
                return false
            }
            let i = self.sqrtValue.intValue
            var j = 5
            while j <= i {
                if self.intValue % j == 0 || self.intValue % (j + 2) == 0 {
                    return false
                }
                j = j + 6
            }
            return true
        }
    }
}
