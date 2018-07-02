// UIAlertController+MTExtension.swift

// 日期：2018/7/2.
// 作者：Nolan   

import UIKit

extension UIAlertController {
    public func show() {
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }
}
