//
// UIViewController+MTExtension.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import UIKit

extension UIViewController {
    
    /// 当前显示的ViewController
    public static var current: UIViewController? {
        return UIWindow.current?.rootViewController?.topViewController
    }

    /// 当前显示的控制器
    public var topViewController: UIViewController {
        if let nav = self as? UINavigationController {
            if let visible = nav.visibleViewController {
                return visible.topViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.topViewController
            }
        }
        if let presented = self.presentedViewController {
            return presented.topViewController
        }
        return self
    }
}
