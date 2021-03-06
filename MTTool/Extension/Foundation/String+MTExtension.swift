//
//  String+MTExtension.swift
//  MTToolDemo
//
//  Created by Nolan on 2018/7/2.
//  Copyright © 2018年 Nolan. All rights reserved.
//

import UIKit

extension String {

    /// 转换为NSString类型
    public var toNSString: NSString { return self as NSString }
    
    /// html字符串的多属性字符串，可直接赋值给控件，e.g: UILabel().attributedText = "exampleHtmlStr".htmlAttributedString
    /// 注意：使用html多属性字符串可有效但不能完全避免字符串里有特殊字符（如阿拉伯字母）造成的显示错乱
    public var htmlAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    /// 字符串长度，同系统属性 count
    public var length: Int {
        return self.count
    }
    
    /// 添加到粘贴板
    public func addToPasteboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self
    }
    
}

// MARK: - 字符相关操作
extension String {
    /// 字符串中某个字符的个数
    ///
    /// - Parameter substring: 指定字符
    /// - Returns: 指定字符个数
    public func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count - 1
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
}

// MARK: - 数字型字符串操作
extension String {
    
    /// 字符串转为NSNumber类型
    public var number: NSNumber? {
        return NumberFormatter().number(from: self)
    }
    
    /// 判断字符串是否是数字型
    public var isNumber: Bool {
        return number != nil ? true : false
    }
    
    /// 字符串转为Int类型
    public var toInt: Int? {
        return isNumber ? number?.intValue : nil
    }

    
    /// 字符串转为Double类型
    public var toDouble: Double? {
        return isNumber ? number?.doubleValue : nil
    }
    
    /// 字符串转为Float类型
    public var toFloat: Float? {
        return isNumber ? number?.floatValue : nil
    }

}

// MARK: - 64位字符串
extension String {
    init?(base64: String) {
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
}

// MARK: - 字符串类型判断
extension String {
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
    
    /// 是否是单个emoji字符
    public var isSingleEmoji: Bool {
        return self.count == 1 && containsEmoji
    }
    
    /// 是否包含emoji
    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }
    
    /// 字符串是否只包含emoji
    var containsOnlyEmoji: Bool {
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji && !$0.isZeroWidthJoiner
            })
    }
    
    /// emoji字符串
    var emojiString: String {
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    /// emoji字符集
    var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        
        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.isZeroWidthJoiner, !scalar.isZeroWidthJoiner {
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            
            previousScalar = scalar
        }
        
        scalars.append(currentScalarSet)
        
        return scalars.map { $0.map { String($0) }.reduce("", +) }
    }
    
    /// emoji字符UnicodeScalar集
    fileprivate var emojiScalars: [UnicodeScalar] {
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner, cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
                
            } else if cur.isEmoji {
                chars.append(cur)
            }
            
            previous = cur
        }
        
        return chars
    }
    
    func dropAllEmojis() -> String {
        var chars: [UnicodeScalar] = []
        for cur in unicodeScalars {
            if !cur.isEmoji {
                chars.append(cur)
            }
        }
        return chars.map { String($0) }.reduce("", +)
    }
    
    func emojiAndOtherTypeCount() -> (emojiCount: UInt, otherCount: UInt) {
        var emojiChars: [UnicodeScalar] = []
        var otherChars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner, cur.isEmoji {
                emojiChars.append(previous)
                emojiChars.append(cur)
            } else if cur.isEmoji {
                emojiChars.append(cur)
            } else {
                otherChars.append(cur)
            }
            
            previous = cur
        }
        
        return (0, 0)
    }
}

extension String {
    public var charactorCount: UInt {
        let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
        return self.charactorNumberWithEncoding(encoding: encoding)
    }
    
    public func charactorNumberWithEncoding(encoding: String.Encoding = String.Encoding.utf8) -> UInt {
        var length: UInt = 0
        var p = self.cString(using: encoding)
        let lengthOfBytes = self.lengthOfBytes(using: encoding)
        for _ in 0..<lengthOfBytes {
            if p != nil {
                p?.removeFirst()
                length = length + 1
            } else {
                p?.removeFirst()
            }
        }
        return length
    }
}
