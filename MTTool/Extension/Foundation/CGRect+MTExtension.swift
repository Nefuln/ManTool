//
// CGRect+MTExtension.swift
//
// 日期：2018/7/11.
// 作者：Nolan   

import UIKit

extension CGRect {
    
    /// == origin.x
    public var x: CGFloat {
        set {
            self.origin.x = newValue
        }
        get {
            return self.origin.x
        }
    }
    
    /// == origin.y
    public var y: CGFloat {
        set {
            self.origin.y = newValue
        }
        get {
            return self.origin.y
        }
    }
    
    /// == size.width
    public var width: CGFloat {
        set {
            self.size.width = newValue
        }
        get {
            return self.size.width
        }
    }
    
    /// == size.height
    public var height: CGFloat {
        set {
            self.size.height = newValue
        }
        get {
            return self.size.height
        }
    }
    
    /// 周长
    public var girth: CGFloat {
        return (self.width + self.height) * 2
    }
    
    /// 面积
    public var area: CGFloat {
        return self.width * self.height
    }
    
    /// 等比例缩放
    ///
    /// - Parameter rate: 缩放比例
    /// - Returns: 缩放过的数据
    public func scale(rate: CGFloat) -> CGRect {
        return CGRect(x: self.x * rate, y: self.y * rate, width: self.width * rate, height: self.height * rate)
    }
}
