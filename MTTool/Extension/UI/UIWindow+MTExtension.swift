//
// UIWindow+MTExtension.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import UIKit

extension UIWindow {
    
    /// app当前显示window
    public static var current: UIWindow? {
        for subWindow in UIApplication.shared.windows {
            if subWindow.windowLevel != UIWindowLevelNormal {
                return subWindow
            }
        }
        return UIApplication.shared.keyWindow
    }
}
