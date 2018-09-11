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

// MARK: - 按钮的点击事件回调block
extension UIButton {
    private struct MTButtonAssociationTapBlockKey {
        static var tapBlockKey = "MTButton_TapBlock"
    }
    
    public var tapBlock: ((_ btn: UIButton)->Void)? {
        get {
            return self.getAssociatedObject(key: &MTButtonAssociationTapBlockKey.tapBlockKey)
        }
        set {
            self.setAssociatedObject(key: &MTButtonAssociationTapBlockKey.tapBlockKey, value: newValue, type: .Copy)
            self.addTarget(self, action: #selector(UIButton.handleTapAction(_:)), for: UIControlEvents.touchUpInside)
        }
    }
    
    @objc private func handleTapAction(_ btn: UIButton) {
        self.tapBlock?(btn)
    }
}

// MARK: - 防止重复点击
extension UIButton {
    private struct MTButtonRepeatedClicksKeys {
        static var allowRepeat = "MTButton_AllowRepeat"
        static var lastTapTime = "MTButton_LastTapTime"
        static var repeatClickInterval = "MTButton_repeatClickInterval"
    }
    
    /// 是否允许重复点击，默认为允许
    public var allowRepeat: Bool {
        get {
            return self.getAssociatedObject(key: &MTButtonRepeatedClicksKeys.allowRepeat, defaultValue: true)!
        }
        set {
            if self.allowRepeat == newValue {
                return
            }
            self.setAssociatedObject(key: &MTButtonRepeatedClicksKeys.allowRepeat, value: newValue, type: MTAssociationType.Retain)
            guard let originMethod = self.getInstanceMethod(#selector(UIButton.sendAction(_:to:for:))) else { return }
            guard let destinationMethod = self.getInstanceMethod(#selector(UIButton.MT_sendAction(_:to:for:))) else { return }
            MT_exchangeMethodImplementations(origin: originMethod, destination:destinationMethod)
        }
    }
    
    /// 两次点击之间的间隔时间，默认为0.5s
    public var repeatClickInterval: TimeInterval {
        get {
            return self.getAssociatedObject(key: &MTButtonRepeatedClicksKeys.repeatClickInterval, defaultValue: 0.5)!
        }
        set {
            self.setAssociatedObject(key: &MTButtonRepeatedClicksKeys.repeatClickInterval, value: newValue, type: MTAssociationType.Retain)
        }
    }
    
    /// 记录上次点击时间
    private var lastTapTime: TimeInterval {
        get {
            return self.getAssociatedObject(key: &MTButtonRepeatedClicksKeys.lastTapTime, defaultValue: 0)!
        }
        set {
            self.setAssociatedObject(key: &MTButtonRepeatedClicksKeys.lastTapTime, value: newValue, type: MTAssociationType.Retain)
        }
    }
    
    /// 使用运行时监听按钮点击事件，并做相应的防止重复点击的处理
    @objc private func MT_sendAction(_ action: Selector, to target: AnyObject?, for event: UIEvent?) {
        let currentTime = Date().timeIntervalSince1970
        if currentTime - self.lastTapTime < self.repeatClickInterval {
            return
        }
        self.lastTapTime = currentTime
        self.MT_sendAction(action, to: target, for: event)
    }
}

// MARK: - 增大点击区域
extension UIButton {
    private struct MTButtonAreaKeys {
        static var minClickArea = "MTButton_ClickArea"
    }
    
    public var minClickArea: CGSize? {
        get {
            return self.getAssociatedObject(key: &MTButtonAreaKeys.minClickArea)
        }
        set {
            self.setAssociatedObject(key: &MTButtonAreaKeys.minClickArea, value: newValue)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let tmpSize = self.minClickArea else {
            return super.point(inside: point, with: event)
        }
        let realSize = self.bounds
        let canClickArea: CGRect = realSize.insetBy(dx: -max(tmpSize.width-realSize.size.width, 0), dy: -max(tmpSize.height-realSize.size.height, 0))
        return canClickArea.contains(point)
    }
}
