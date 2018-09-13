//
// DispatchQueue.swift
//
// 日期：2018/9/13.
// 作者：Nolan   

import Foundation

extension DispatchQueue {
    
    private static var onceTracker = Set<String>()
    
    public static func once(token: String, block: ()->Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if onceTracker.contains(token) {
            return
        }
        onceTracker.insert(token)
        block()
    }
}
