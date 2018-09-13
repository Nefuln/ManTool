// NSObject+MTExtension.swift

// 日期：2018/7/3.
// 作者：Nolan   

import Foundation

extension NSObject {
    
    /// 类名称（不带命名空间的前缀）
    public static var className: String {
        return String(describing: self)
    }
    
    /// 类名称（不带命名空间的前缀）
    public var className: String {
        return type(of: self).className
    }
    
    /// 类名称（带命名空间的前缀）
    public static var classNameOfComplete: String {
        return MT_classNameFromClass(self)!
    }
    
    /// 类名称（带命名空间的前缀）
    public var classNameOfComplete: String {
        return MT_classNameFromObject(self)!
    }
    
    /// 根据对象获取其AnyClass
    public var classType: AnyClass {
        return MT_classFromObject(self)!
    }
    
    public static var classType: AnyClass {
        return MT_classFromString(self.classNameOfComplete)!
    }
    
}

/// 关联属性类型
///
/// - Strong: Strong
/// - Weak: Weak
/// - Copy: Copy
/// - Retain: Retain
public enum MTAssociationType {
    case Strong
    case Weak
    case Copy
    case Retain
}

// MARK: - 关联属性
extension NSObject {
    
    /// 设置关联属性
    ///
    /// - Parameters:
    ///   - key: 键
    ///   - value: 值
    ///   - type: 属性类型
    public func setAssociatedObject<T>(key: UnsafeRawPointer, value: T?, type: MTAssociationType = .Strong) {
        var policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
        switch type {
        case .Weak:
            policy = .OBJC_ASSOCIATION_ASSIGN
        case .Copy:
            policy = .OBJC_ASSOCIATION_COPY_NONATOMIC
        default:
            break
        }
        objc_setAssociatedObject(self, key, value, policy)
    }
    
    /// 获取关联属性的值
    ///
    /// - Parameters:
    ///   - key: 键
    ///   - defaultValue: 默认值，默认为nil
    /// - Returns: 值
    public func getAssociatedObject<T>(key: UnsafeRawPointer, defaultValue: T? = nil) -> T? {
        guard let value = objc_getAssociatedObject(self, key) else {
            return defaultValue
        }
        return value as? T
    }
}

// MARK: - 方法
extension NSObject {
    public func getInstanceMethod(_ name: Selector) -> Method? {
        return MT_getInstanceMethod(cls: self.classType, name: name)
    }
    
    public func getClassMethod(_ name: Selector) -> Method? {
        return MT_getClassMethod(cls: self.classType, name: name)
    }
    
    public static func getInstanceMethod(_ name: Selector) -> Method? {
        return MT_getInstanceMethod(cls: self.classType, name: name)
    }
    
    public static func getClassMethod(_ name: Selector) -> Method? {
        return MT_getClassMethod(cls: self.classType, name: name)
    }
}
