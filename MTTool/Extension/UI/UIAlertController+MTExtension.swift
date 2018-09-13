// UIAlertController+MTExtension.swift

// 日期：2018/7/2.
// 作者：Nolan   

import UIKit

extension UIAlertController {
    
    public static func alertForTitle(title: String?, message: String?, preferredStyle: UIAlertControllerStyle = .alert, actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach({ alert.addAction($0) })
        alert.show()
    }
    
    public func show() {
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }
    
    public func addActions(actions: UIAlertAction...) {
        actions.forEach({ self.addAction($0) })
    }
}
