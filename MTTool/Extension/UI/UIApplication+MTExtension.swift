//
// UIApplication+MTExtension.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import UIKit

extension UIApplication {
    
    /// 在后台运行一段block
    ///
    /// - Parameters:
    ///   - closure: 在后台运行的block
    ///   - expirationHandler: 在超过系统限制时间时执行的block
    public func runInBackground(_ closure: @escaping () -> Void, expirationHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let taskID: UIBackgroundTaskIdentifier
            if let expirationHandler = expirationHandler {
                taskID = self.beginBackgroundTask(expirationHandler: expirationHandler)
            } else {
                taskID = self.beginBackgroundTask(expirationHandler: { })
            }
            closure()
            self.endBackgroundTask(taskID)
        }
    }
}
