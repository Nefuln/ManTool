//
// Character+MTExtension.swift
//
// 日期：2018/7/3.
// 作者：Nolan   

import Foundation

extension Character {
    
    /// 转化为String
    public var toString: String { return String(self) }
    
    /// 转化为Int
    public var toInt: Int? { return Int(String(self)) }
    
    /// 小写
    public var lowercased: Character {
        let s = String(self).lowercased()
        return s[s.startIndex]
    }
    
    /// 大写
    public var uppercased: Character {
        let s = String(self).uppercased()
        return s[s.startIndex]
    }
    
    /// 是否是表情符号
    var isEmoji: Bool {
        return String(self).isSingleEmoji
    }
    
    var isChinese: Bool {
        for u in self.unicodeScalars {
            if u.isChinese {
                return true
            }
        }
        return false
    }
}
