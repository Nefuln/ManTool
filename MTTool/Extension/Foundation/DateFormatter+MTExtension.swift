//
// DateFormatter+MTExtension.swift
//
// 日期：2018/9/13.
// 作者：Nolan   

import Foundation

extension DateFormatter {
    
    /// 增加单例方法，避免重复调用构造器方法造成的性能损耗
    public static let dateFormatter: DateFormatter = DateFormatter()
}
