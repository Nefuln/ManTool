//
// UIColor+MTExtension.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import UIKit

extension UIColor {
    
    /// 遍历构造器：支持传入色值范围(0~255)
    ///
    /// - Parameters:
    ///   - r: 红色色值
    ///   - g: 绿色色值
    ///   - b: 蓝色色值
    ///   - a: 透明度，默认为1
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 遍历构造器：支持16进制字符串
    ///
    /// - Parameters:
    ///   - hexString: 16进制字符串
    ///   - alpha: 透明度，默认为1
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        guard let hex = Int(formatted, radix: 16) else { return nil }
        let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
        let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
        let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 红色色值
    public var red: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    
    /// 绿色色值
    public var green: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    
    /// 蓝色色值
    public var blue: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
    
    /// 透明度
    public var alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    
    /// 随机颜色
    ///
    /// - Parameter randomAlpha: true：透明度随机，false：透明度为1
    /// - Returns: 随机颜色
    public static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}
