
//
// MTRuntime.swift
//
// 日期：2018/9/5.
// 作者：Nolan   

import Foundation

/// 注册新类
///
/// - Parameters:
///   - superClass: 继承于哪个类，e.g: NSObject...
///   - name: 类名
public func MT_registClass(superClass: AnyClass?, name: String) {
    if MT_isExistClass(className: name) { return }
    guard let allocClass: AnyClass = objc_allocateClassPair(superClass, name, 0) else { return }
    objc_registerClassPair(allocClass)
}

/// 判断类是否已存在
///
/// - Parameter className: 类名
/// - Returns: true: 已存在， false：不存在
public func MT_isExistClass(className: String) -> Bool {
    return MT_classFromString(className) != nil
}

/// 根据类名获取类
///
/// - Parameter className: 类名
/// - Returns: 类
public func MT_classFromString(_ className: String) -> AnyClass? {
    return NSClassFromString(className)
}

/// 获取对象的类型
///
/// - Parameter obj: 任意对象
/// - Returns: 对象的类型
public func MT_classFromObject(_ obj: Any?) -> AnyClass? {
    return object_getClass(obj)
}

/// 获取某给对象的类型名称
///
/// - Parameter obj: 任意对象
/// - Returns: 对象的类型名称
public func MT_classNameFromObject(_ obj: Any?) -> String? {
    return String(cString: object_getClassName(obj))
}

/// 获取某个类的类型名称
///
/// - Parameter cls: 类
/// - Returns: 类的类型名称
public func MT_classNameFromClass(_ cls: AnyClass?) -> String? {
    if cls == nil { return nil }
    return String(cString: class_getName(cls))
}

/// 获取某个命名空间内的所有类
///
/// - Parameter atNamespace: 命名空间
/// - Returns: 该命名空间内的类的总数
public func MT_getAllClassList(atNamespace: String? = nil) -> (count: UInt32, allClassList: [String]?) {
    var count: UInt32 = 0
    guard let list: AutoreleasingUnsafeMutablePointer<Swift.AnyClass> = objc_copyClassList(&count) else { return (count, nil) }
    if count == 0 { return (count, nil) }
    var allClassList = [String]()
    for i in 0..<count {
        guard let className = MT_classNameFromClass(list[Int(i)]) else { continue }
        if atNamespace == nil {
            allClassList.append(className)
        } else if className.hasPrefix(atNamespace!) {
            allClassList.append(className)
        }
    }
    return (UInt32(allClassList.count), allClassList)
}

/// 判断一个类是不是元类
///
/// - Parameter cls: 类
/// - Returns: true: 是元类， false: 不是元类
public func MT_isMutaClass(_ cls: AnyClass?) -> Bool {
    return class_isMetaClass(cls)
}

/// 获取类的父类
///
/// - Parameter cls: 类
/// - Returns: 父类
public func MT_superClass(_ cls: AnyClass?) -> AnyClass? {
    return class_getSuperclass(cls)
}

/// 获取指定类的所有属性
///
/// - Parameter cls: 类
/// - Returns: 类的属性列表
public func MT_getPropertyList(cls: AnyClass?) -> (count: UInt32, property: [String]?) {
    var count: UInt32 = 0
    guard let propertyList: UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(cls, &count) else { return (0, nil) }
    if count == 0  { return (0, nil) }
    var propertys = [String]()
    for i in 0..<count {
        let property = propertyList[Int(i)]
        let p = property_getName(property)
        propertys.append(String(cString: p))
    }
    return (UInt32(propertys.count), propertys)
}

//public func MT_get() {
//    class_getImageName(<#T##cls: AnyClass?##AnyClass?#>)
//}

public func MT_getFuncList(cls: AnyClass?) {
    var count: UInt32 = 0
    guard let funcList: UnsafeMutablePointer<Method> = class_copyMethodList(cls, &count) else { return }
    if count == 0 { return }
//    var methods = []
    for i in 0..<count {
        let f = method_getName(funcList[Int(i)])
    }
}

/// 获取指定类的指定实例方法
///
/// - Parameters:
///   - cls: 类
///   - name: 方法
/// - Returns: 方法
public func MT_getInstanceMethod(cls: AnyClass?, name: Selector) -> Method? {
    return class_getInstanceMethod(cls, name)
}

public func MT_exchangeMethodImplementations(origin: Method, destination: Method) {
    method_exchangeImplementations(origin, destination)
}
