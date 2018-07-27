// UIButton+MTExtension.swift

// 日期：2018/7/2.
// 作者：Nolan   

import UIKit

public enum MTButtonEdgeInsetsStyle: Int {
    case Top = 0        //图片在上，文字在下
    case Bottom         //图片在下，文字在上
    case Left           //图片在左，文字在右
    case Right          //图片在右，文字在左
}

extension UIButton {
    
    /// 设置不同状态的背景色
    ///
    /// - Parameters:
    ///   - color: 背景色
    ///   - forState: 按钮状态
    public func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        self.setBackgroundImage(UIImage.colorImage(color), for: forState)
    }
    
    /// 重新布局图片和文字的位置
    ///
    /// - Parameters:
    ///   - style: 位置枚举类型，默认为图片在左，文字在右
    ///   - space: 图片和文字之间的间距，默认为2
    public func layoutButton(style: MTButtonEdgeInsetsStyle = .Left, space: CGFloat = 2) {
        let imageWidth: CGFloat = self.imageView?.width ?? 0
        let imageHeight: CGFloat = self.imageView?.height ?? 0
        let labelWidth: CGFloat = self.titleLabel?.width ?? 0
        let labelhHeight: CGFloat = self.titleLabel?.height ?? 0
        
        var imageEdgeInsets = UIEdgeInsets()
        var labelEdgeInsets = UIEdgeInsets()
        switch style {
        case .Top:
            imageEdgeInsets = UIEdgeInsets(top: -labelhHeight-space*0.5, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-space*0.5, right: 0)
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelhHeight-space*0.5, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space*0.5, left: -imageWidth, bottom: 0, right: 0)
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space*0.5, bottom: 0, right: space*0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space*0.5, bottom: 0, right: -space*0.5)
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space*0.5, bottom: 0, right: -labelWidth-space*0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-space*0.5, bottom: 0, right: imageWidth+space*0.5)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
