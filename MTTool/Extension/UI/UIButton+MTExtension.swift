// UIButton+MTExtension.swift

// 日期：2018/7/2.
// 作者：Nolan   

import UIKit

extension UIButton {
    public func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        self.setBackgroundImage(UIImage.colorImage(color), for: forState)
    }
}
