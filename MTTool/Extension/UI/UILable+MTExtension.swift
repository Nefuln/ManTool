//
// UILable+MTExtension.swift
//
// 日期：2018/7/27.
// 作者：Nolan   

import UIKit

extension UILabel {
    
    convenience init(font: UIFont, textColor: UIColor, alignment: NSTextAlignment = .left) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
    }
}
