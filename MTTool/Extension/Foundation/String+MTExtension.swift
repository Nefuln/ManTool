//
//  String+MTExtension.swift
//  MTToolDemo
//
//  Created by Nolan on 2018/7/2.
//  Copyright © 2018年 Nolan. All rights reserved.
//

import Foundation

extension String {
    
    init ? (base64: String) {
        let pad = String(repeating: "=", count: base64.length % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }
    
    /// base64字符串
    public var base64Str: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    /// 字符串长度，同系统属性 count
    public var length: Int {
        return self.count
    }
    
    /// 在某个位置的字符
    ///
    /// - Parameter integerIndex: 位置下标
    public subscript(integerIndex: Int) -> Character? {
        if integerIndex >= length { return nil }
        let index = self.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }
    
    /// 获取某个不可数的开区间的字符串
    ///
    /// - Parameter integerRange: 1..<2
    public subscript(integerRange: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = self.index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start..<end])
    }
    
    /// 获取某个不可数的闭区间的字符串
    ///
    /// - Parameter integerRange: 1...2
    public subscript(integerClosedRange: ClosedRange<Int>) -> String {
        return self[integerClosedRange.lowerBound..<(integerClosedRange.upperBound + 1)]
    }
    
    /// 字符串中某个字符的个数
    ///
    /// - Parameter substring: 指定字符
    /// - Returns: 指定字符个数
    public func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }
    
    /// 字符串中是否包含表情
    ///
    /// - Returns: true：包含，false: 不包含
    public func includesEmoji() -> Bool {
        for i in 0...length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
}
