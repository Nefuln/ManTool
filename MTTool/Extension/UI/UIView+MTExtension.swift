//
// UIView+MTExtension.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import UIKit

extension UIView {
    
    /// 批量添加subview
    ///
    /// - Parameter views: subviews
    public func addSubviews(_ views: UIView...) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
    
    /// 移除所有subview
    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

// MARK: - Transform Extensions
extension UIView {
//    /// EZSwiftExtensions
//    public func setRotationX(_ x: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
//        self.layer.transform = transform
//    }
//
//    /// EZSwiftExtensions
//    public func setRotationY(_ y: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
//        self.layer.transform = transform
//    }
//
//    /// EZSwiftExtensions
//    public func setRotationZ(_ z: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
//        self.layer.transform = transform
//    }
//
//    /// EZSwiftExtensions
//    public func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
//        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
//        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
//        self.layer.transform = transform
//    }
//
//    /// EZSwiftExtensions
//    public func setScale(x: CGFloat, y: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DScale(transform, x, y, 1)
//        self.layer.transform = transform
//    }
}

// MARK: - Frame
extension UIView {
    
    /// == origin.x
    public var x: CGFloat {
        set {
            self.frame.x = newValue
        }
        get {
            return self.frame.x
        }
    }
    
    /// == origin.y
    public var y: CGFloat {
        set {
            self.frame.y = newValue
        }
        get {
            return self.frame.y
        }
    }
    
    /// == size.width
    public var width: CGFloat {
        set {
            self.frame.width = newValue
        }
        get {
            return self.frame.width
        }
    }
    
    /// == size.height
    public var height: CGFloat {
        set {
            self.frame.height = newValue
        }
        get {
            return self.frame.height
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
    
    public func scaleSize(rate: CGFloat) -> CGSize {
        return CGSize(width: self.width * rate, height: self.height * rate)
    }
}
