// UIImage+MTExtension.swift

// 日期：2018/7/2.
// 作者：Nolan   

import UIKit

public enum MTUIImageType: Int {
    case Unknown = 0    // 未知
    case Jpg            // Jpg格式
    case Png            // Png格式
    case Gif            // Gif格式
    case Tiff           // Tiff格式
    case Webp           // Webp格式
    
    static func imageType(data: Data) -> MTUIImageType {
        guard let byte = data.bytes.first else {
            return .Unknown
        }
        switch byte {
        case 0xFF:
            return .Jpg
        case 0x89:
            return .Png
        case 0x47:
            return .Gif
        case 0x49, 0x4d:
            return .Tiff
        case 0x52:
            if data.count < 12 { return .Unknown }
            guard let str = String(data: data[0..<12], encoding: String.Encoding.ascii) else { return .Unknown }
            if str.hasPrefix("RIFF") && str.hasSuffix("WEBP") {
                return .Webp
            } else {
                return .Unknown
            }
        default:
            return .Unknown
        }
    }
}

extension UIImage {
    
    public var type: MTUIImageType {
        return self.data == nil ? .Unknown : MTUIImageType.imageType(data: self.data!)
    }
    
    public var data: Data? {
        guard let resultData = UIImagePNGRepresentation(self) else {
            return UIImageJPEGRepresentation(self, 1.0)
        }
        return resultData
    }
    
    public var sizeByByte: Int {
        return self.data?.count ?? 0
    }
    
    public var sizeByKilobytes: Int {
        return self.sizeByByte/1024
    }
    
    /// 从指定url下载好的图片（会阻碍主线程）
    ///
    /// - Parameter urlString: 指定url
    public convenience init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init(data: Data())
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            self.init(data: Data())
            return
        }
        self.init(data: data)
    }

    /// 将UIView转换为UIImage
    ///
    /// - Parameter fromView: 需要转化的UIView
    /// - Returns: 生成对应的UIImage
    public static func image(fromView: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(fromView.bounds.size, fromView.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext()}
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        fromView.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        return img
    }
    
    /// 压缩图片
    ///
    /// - Parameter rate: 比率
    /// - Returns: 压缩过的图片Data
    public func compressImage(rate: CGFloat) -> Data? {
        return UIImageJPEGRepresentation(self, rate)
    }

}

// MARK: - 颜色相关
extension UIImage {
    /// 生成一张带颜色的图片
    ///
    /// - Parameter color: 图片颜色
    /// - Returns: 一张带颜色的图片
    public static func colorImage(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage
    }
    
    /// 改变图片颜色
    ///
    /// - Parameter tintColor: 最终颜色
    /// - Returns: 改变后颜色的图片
    public func changeColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        return newImage
    }
}

// MARK: - 尺寸相关
extension UIImage {
    
    /// 图片加圆角
    ///
    /// - Parameter corner: 圆角半径
    /// - Returns: 加工后图片
    public func corner(_ corner: CGFloat, byRoundingCorners: UIRectCorner = UIRectCorner.allCorners) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.addPath(UIBezierPath(roundedRect: rect, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: corner, height: corner)).cgPath)
        context?.clip()
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 缩放图片
    ///
    /// - Parameters:
    ///   - width: 目标宽度
    ///   - height: 目标高度
    /// - Returns: 缩放后的图片
    public func scaleTo(width: CGFloat, height: CGFloat) -> UIImage {
        return self.scaleTo(size: CGSize(width: width, height: height))
    }

    /// 等比例缩放
    ///
    /// - Parameter rate: 比例
    /// - Returns: 缩放后的图片
    public func scaleTo(rate: CGFloat) -> UIImage {
        return self.scaleTo(size: CGSize(width: self.size.width * rate, height: self.size.height * rate))
    }
    
    /// 等比例缩放
    ///
    /// - Parameter height: 指定高度
    /// - Returns: 缩放后的图片
    public func scaleTo(height: CGFloat) -> UIImage {
        let aspectSize = CGSize(width: aspectWidthForHeight(height), height: height)
        return self.scaleTo(size: aspectSize)
    }
    
    /// 等比例缩放
    ///
    /// - Parameter width: 指定宽度
    /// - Returns: 缩放后的图片
    public func scaleTo(width: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: width, height: aspectHeightForWidth(width))
        return self.scaleTo(size: aspectSize)
    }
    
    /// 缩放图片
    ///
    /// - Parameter size: 目标尺寸
    /// - Returns: 缩放后的图片
    public func scaleTo(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 裁切图片
    ///
    /// - Parameter bound: 裁切区域
    /// - Returns: 裁切过的图片
    public func croppedImage(_ bound: CGRect) -> UIImage? {
        var scaledBounds = bound
        if self.size.width < bound.origin.x {
            scaledBounds.origin.x = self.size.width
        }
        if self.size.height < bound.origin.y {
            scaledBounds.origin.y = self.size.height
        }
        let imageRef = self.cgImage?.cropping(to: scaledBounds.scale(rate: self.scale))
        let croppedImage: UIImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: UIImageOrientation.up)
        return croppedImage
    }
    
    /// 根据给定宽度获取等比例高度
    ///
    /// - Parameter width: 给定宽度
    /// - Returns: 等比例高度
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }
    
    /// 根据给定高度获取等比例宽度
    ///
    /// - Parameter height: 给定高度
    /// - Returns: 等比例宽度
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
    
}
