//
// Character+MTExtension.swift
//
// 日期：2018/7/3.
// 作者：Nolan   

import Foundation

extension Character {
    
    public var toString: String { return String(self) }
    
    public var toInt: Int? { return Int(String(self)) }
    
    /// EZSE: Convert the character to lowercase
    public var lowercased: Character {
        let s = String(self).lowercased()
        return s[s.startIndex]
    }
    
    /// EZSE: Convert the character to uppercase
    public var uppercased: Character {
        let s = String(self).uppercased()
        return s[s.startIndex]
    }
    
    /// EZSE : Checks if character is emoji
    var isEmoji: Bool {
        return String(self).includesEmoji()
    }
    
}
