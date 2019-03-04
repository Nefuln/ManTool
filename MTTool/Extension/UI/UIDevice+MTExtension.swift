//
//  UIDevice+MTExtension.swift
//  Demo
//
//  Created by ManThirty on 2018/6/28.
//  Copyright © 2018年 ManThirty All rights reserved.
//

import UIKit

var MTIsIPhoneX: Bool {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0) > 0
    } else {
        return false
    }
}

extension UIDevice {
    /// 设备类型
    var deviceType: MTDeviceType {
        return self.deviceModel == nil ? .None : self.deviceModel!.deviceType
    }
    
    /// 系统平台描述
    var platformDesc: String {
        return self.deviceModel == nil ? "None" : self.deviceModel!.desc
    }
    
    /// 设备信息
    var deviceModel: MTDeviceModel? {
        let model = self.platfromList.filter{ return $0.platform == self.platform }.first
        assert(model != nil, "设备信息列表不包括当前设备")
        return model
    }
    
    /// 是否是手机
    var isPhone: Bool {
        return self.deviceType == .iPhone
    }
    
    /// 是否是模拟器
    var isSimulator: Bool {
        return self.deviceType == .Simulator
    }
    
    /// 手机型号：不是手机时返回None
    var iPhoneType: MTPhoneDeviceType {
        return self.isPhone ? (self.deviceModel as! MTPhoneModel).phoneType : .None
    }
    
    /// 平台信息
    var platform: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// 电池电量
    var MT_batteryQuantity: Float {
        self.isBatteryMonitoringEnabled = true
        let quantity = self.batteryLevel
        self.isBatteryMonitoringEnabled = false
        return quantity
    }
    
    /// 电池状态
    var MT_batteryState: UIDeviceBatteryState {
        self.isBatteryMonitoringEnabled = true
        let state = self.batteryState
        self.isBatteryMonitoringEnabled = false
        return state
    }
}

// MARK: - 设备运行内存
extension UIDevice {
    /// 系统物理内存： 单位为b
    var totalMemorySize: UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }

    /// 获取当前可用内存，单位为b

    
    // 获取当前进程占用内存，单位为b
    var useMemory: UInt64? {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                          task_flavor_t(MACH_TASK_BASIC_INFO),
                          $0,
                          &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            return info.resident_size
        }
        return nil
    }
}

extension UIDevice {
    /// 磁盘总大小, 单位：b
    var totalDiskSize: Int64 {
        var fs = blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
        }
        return -1
    }
    
    /// 磁盘可用大小, 单位：b
    var availableDiskSize: Int64 {
        var fs = blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_bavail)
        }
        return -1
    }
    
    private func blankof<T>(type:T.Type) -> T {
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
        let val = ptr.pointee
        ptr.deinitialize(count: 1)
        return val
    }
}

// MARK: - 源数据
fileprivate extension UIDevice {
    var platfromList: [MTDeviceModel] {
        // 苹果设备类型说明 ： https://www.theiphonewiki.com/wiki/Models
        let i386 = MTDeviceModel(platform: "i386", deviceType: MTDeviceType.Simulator, desc: "Simulator")
        let x86_64 = MTDeviceModel(platform: "x86_64", deviceType: MTDeviceType.Simulator, desc: "Simulator")

        let airPods = MTDeviceModel(platform: "AirPods1,1", deviceType: MTDeviceType.AirPods, desc: "AirPods")

        let appleTV2_1 = MTDeviceModel(platform: "AppleTV2,1", deviceType: MTDeviceType.AppleTV, desc: "Apple TV (2nd generation)")
        let appleTV3_1 = MTDeviceModel(platform: "AppleTV3,1", deviceType: MTDeviceType.AppleTV, desc: "Apple TV (3rd generation)")
        let appleTV3_2 = MTDeviceModel(platform: "AppleTV3,2", deviceType: MTDeviceType.AppleTV, desc: "Apple TV (3rd generation)")
        let appleTV5_3 = MTDeviceModel(platform: "AppleTV5,3", deviceType: MTDeviceType.AppleTV, desc: "Apple TV (3rd generation)")
        let appleTV6_2 = MTDeviceModel(platform: "AppleTV6,2", deviceType: MTDeviceType.AppleTV, desc: "Apple TV 4K")
        
        let watch1_1 = MTDeviceModel(platform: "Watch1,1", deviceType: MTDeviceType.Watch, desc: "Apple Watch (1st generation)")
        let watch1_2 = MTDeviceModel(platform: "Watch1,2", deviceType: MTDeviceType.Watch, desc: "Apple Watch (1st generation)")
        let watch2_6 = MTDeviceModel(platform: "Watch2,6", deviceType: MTDeviceType.Watch, desc: "Apple Watch Series 1")
        let watch2_7 = MTDeviceModel(platform: "Watch2,7", deviceType: MTDeviceType.Watch, desc: "Apple Watch Series 1")
        let watch2_3 = MTDeviceModel(platform: "Watch2,3", deviceType: MTDeviceType.Watch, desc: "Apple Watch Series 2")
        let watch2_4 = MTDeviceModel(platform: "Watch2,4", deviceType: MTDeviceType.Watch, desc: "Apple Watch Series 2")
        let watch3_1 = MTDeviceModel(platform: "Watch3,1", deviceType: MTDeviceType.Watch, desc: "Apple Watch Series 3")
        let watch3_2 = MTDeviceModel(platform: "Watch3,2", deviceType: MTDeviceType.Watch, desc: "Apple Watch Series 3")
        let watch3_3 = MTDeviceModel(platform: "Watch3,3", deviceType: MTDeviceType.Watch, desc: "Apple Watch Series 3")
        let watch3_4 = MTDeviceModel(platform: "Watch3,4", deviceType: MTDeviceType.Watch, desc: "Apple Watch Series 3")

        let homePod = MTDeviceModel(platform: "AudioAccessory1,1", deviceType: MTDeviceType.HomePod, desc: "HomePod")
        
        let iPad1_1 = MTDeviceModel(platform: "iPad1,1", deviceType: MTDeviceType.iPad, desc: "iPad")
        let iPad2_1 = MTDeviceModel(platform: "iPad2,1", deviceType: MTDeviceType.iPad, desc: "iPad 2")
        let iPad2_2 = MTDeviceModel(platform: "iPad2,2", deviceType: MTDeviceType.iPad, desc: "iPad 2")
        let iPad2_3 = MTDeviceModel(platform: "iPad2,3", deviceType: MTDeviceType.iPad, desc: "iPad 2")
        let iPad2_4 = MTDeviceModel(platform: "iPad2,4", deviceType: MTDeviceType.iPad, desc: "iPad 2")
        let iPad3_1 = MTDeviceModel(platform: "iPad3,1", deviceType: MTDeviceType.iPad, desc: "iPad (3rd generation)")
        let iPad3_2 = MTDeviceModel(platform: "iPad3,2", deviceType: MTDeviceType.iPad, desc: "iPad (3rd generation)")
        let iPad3_3 = MTDeviceModel(platform: "iPad3,3", deviceType: MTDeviceType.iPad, desc: "iPad (3rd generation)")
        let iPad3_4 = MTDeviceModel(platform: "iPad3,4", deviceType: MTDeviceType.iPad, desc: "iPad (4th generation)")
        let iPad3_5 = MTDeviceModel(platform: "iPad3,5", deviceType: MTDeviceType.iPad, desc: "iPad (4th generation)")
        let iPad3_6 = MTDeviceModel(platform: "iPad3,6", deviceType: MTDeviceType.iPad, desc: "iPad (4th generation)")
        let iPad4_1 = MTDeviceModel(platform: "iPad4,1", deviceType: MTDeviceType.iPad, desc: "iPad Air")
        let iPad4_2 = MTDeviceModel(platform: "iPad4,2", deviceType: MTDeviceType.iPad, desc: "iPad Air")
        let iPad4_3 = MTDeviceModel(platform: "iPad4,3", deviceType: MTDeviceType.iPad, desc: "iPad Air")
        let iPad5_3 = MTDeviceModel(platform: "iPad5,3", deviceType: MTDeviceType.iPad, desc: "iPad Air 2")
        let iPad5_4 = MTDeviceModel(platform: "iPad5,4", deviceType: MTDeviceType.iPad, desc: "iPad Air 2")
        let iPad6_7 = MTDeviceModel(platform: "iPad6_7", deviceType: MTDeviceType.iPad, desc: "iPad Pro (12.9-inch)")
        let iPad6_8 = MTDeviceModel(platform: "iPad6_8", deviceType: MTDeviceType.iPad, desc: "iPad Pro (12.9-inch)")
        let iPad6_3 = MTDeviceModel(platform: "iPad6_3", deviceType: MTDeviceType.iPad, desc: "iPad Pro (9.7-inch)")
        let iPad6_4 = MTDeviceModel(platform: "iPad6_4", deviceType: MTDeviceType.iPad, desc: "iPad Pro (9.7-inch)")
        let iPad6_11 = MTDeviceModel(platform: "iPad6_11", deviceType: MTDeviceType.iPad, desc: "iPad (5th generation)")
        let iPad6_12 = MTDeviceModel(platform: "iPad6_12", deviceType: MTDeviceType.iPad, desc: "iPad (5th generation)")
        let iPad7_1 = MTDeviceModel(platform: "iPad7,1", deviceType: MTDeviceType.iPad, desc: "iPad Pro (12.9-inch, 2nd generation)")
        let iPad7_2 = MTDeviceModel(platform: "iPad7,2", deviceType: MTDeviceType.iPad, desc: "iPad Pro (12.9-inch, 2nd generation)")
        let iPad7_3 = MTDeviceModel(platform: "iPad7,3", deviceType: MTDeviceType.iPad, desc: "iPad Pro (10.5-inch)")
        let iPad7_4 = MTDeviceModel(platform: "iPad7,4", deviceType: MTDeviceType.iPad, desc: "iPad Pro (10.5-inch)")
        
        let iPad2_5 = MTDeviceModel(platform: "iPad2,5", deviceType: MTDeviceType.iPadMini, desc: "iPad mini")
        let iPad2_6 = MTDeviceModel(platform: "iPad2,6", deviceType: MTDeviceType.iPadMini, desc: "iPad mini")
        let iPad2_7 = MTDeviceModel(platform: "iPad2,7", deviceType: MTDeviceType.iPadMini, desc: "iPad mini")
        let iPad4_4 = MTDeviceModel(platform: "iPad4,4", deviceType: MTDeviceType.iPadMini, desc: "iPad mini 2")
        let iPad4_5 = MTDeviceModel(platform: "iPad4,5", deviceType: MTDeviceType.iPadMini, desc: "iPad mini 2")
        let iPad4_6 = MTDeviceModel(platform: "iPad4,6", deviceType: MTDeviceType.iPadMini, desc: "iPad mini 2")
        let iPad4_7 = MTDeviceModel(platform: "iPad4,7", deviceType: MTDeviceType.iPadMini, desc: "iPad mini 3")
        let iPad4_8 = MTDeviceModel(platform: "iPad4,8", deviceType: MTDeviceType.iPadMini, desc: "iPad mini 3")
        let iPad4_9 = MTDeviceModel(platform: "iPad4,9", deviceType: MTDeviceType.iPadMini, desc: "iPad mini 3")
        let iPad5_1 = MTDeviceModel(platform: "iPad5,1", deviceType: MTDeviceType.iPadMini, desc: "iPad mini 4")
        let iPad5_2 = MTDeviceModel(platform: "iPad5,2", deviceType: MTDeviceType.iPadMini, desc: "iPad mini 4")

        let iPhone1_1 = MTPhoneModel(platform: "iPhone1,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 1G", phoneType: .iPhone1G)
        let iPhone1_2 = MTPhoneModel(platform: "iPhone1,2", deviceType: MTDeviceType.iPhone, desc: "iPhone 3G", phoneType: .iPhone3G)
        let iPhone2_1 = MTPhoneModel(platform: "iPhone2,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 3GS", phoneType: .iPhone3GS)
        let iPhone3_1 = MTPhoneModel(platform: "iPhone3,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 4", phoneType: .iPhone4)
        let iPhone3_2 = MTPhoneModel(platform: "iPhone3,2", deviceType: MTDeviceType.iPhone, desc: "iPhone 4", phoneType: .iPhone4)
        let iPhone4_1 = MTPhoneModel(platform: "iPhone4,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 4S", phoneType: .iPhone4S)
        let iPhone5_1 = MTPhoneModel(platform: "iPhone5,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 5", phoneType: .iPhone5)
        let iPhone5_2 = MTPhoneModel(platform: "iPhone5,2", deviceType: MTDeviceType.iPhone, desc: "iPhone 5", phoneType: .iPhone5)
        let iPhone5_3 = MTPhoneModel(platform: "iPhone5,3", deviceType: MTDeviceType.iPhone, desc: "iPhone 5C", phoneType: .iPhone5C)
        let iPhone5_4 = MTPhoneModel(platform: "iPhone5,4", deviceType: MTDeviceType.iPhone, desc: "iPhone 5C", phoneType: .iPhone5C)
        let iPhone6_1 = MTPhoneModel(platform: "iPhone6,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 5S", phoneType: .iPhone5S)
        let iPhone6_2 = MTPhoneModel(platform: "iPhone6,2", deviceType: MTDeviceType.iPhone, desc: "iPhone 5S", phoneType: .iPhone5S)
        let iPhone7_1 = MTPhoneModel(platform: "iPhone7,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 6 Plus", phoneType: .iPhone6Plus)
        let iPhone7_2 = MTPhoneModel(platform: "iPhone7,2", deviceType: MTDeviceType.iPhone, desc: "iPhone 6", phoneType: .iPhone6)
        let iPhone8_1 = MTPhoneModel(platform: "iPhone8,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 6s", phoneType: .iPhone6S)
        let iPhone8_2 = MTPhoneModel(platform: "iPhone8,2", deviceType: MTDeviceType.iPhone, desc: "iPhone 6s Plus", phoneType: .iPhone6SPlus)
        let iPhone8_4 = MTPhoneModel(platform: "iPhone8,4", deviceType: MTDeviceType.iPhone, desc: "iPhone SE", phoneType: .iPhoneSE)
        let iPhone9_1 = MTPhoneModel(platform: "iPhone9,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 7", phoneType: .iPhone7)
        let iPhone9_3 = MTPhoneModel(platform: "iPhone9,3", deviceType: MTDeviceType.iPhone, desc: "iPhone 7", phoneType: .iPhone7)
        let iPhone9_2 = MTPhoneModel(platform: "iPhone9,2", deviceType: MTDeviceType.iPhone, desc: "iPhone 7 Plus", phoneType: .iPhone7Plus)
        let iPhone9_4 = MTPhoneModel(platform: "iPhone9,4", deviceType: MTDeviceType.iPhone, desc: "iPhone 7 Plus", phoneType: .iPhone7Plus)
        let iPhone10_1 = MTPhoneModel(platform: "iPhone10,1", deviceType: MTDeviceType.iPhone, desc: "iPhone 8", phoneType: .iPhone8)
        let iPhone10_4 = MTPhoneModel(platform: "iPhone10,4", deviceType: MTDeviceType.iPhone, desc: "iPhone 8", phoneType: .iPhone8)
        let iPhone10_2 = MTPhoneModel(platform: "iPhone10,2", deviceType: MTDeviceType.iPhone, desc: "iPhone 8 Plus", phoneType: .iPhone8Plus)
        let iPhone10_5 = MTPhoneModel(platform: "iPhone10,5", deviceType: MTDeviceType.iPhone, desc: "iPhone 8 Plus", phoneType: .iPhone8Plus)
        let iPhone10_3 = MTPhoneModel(platform: "iPhone10,3", deviceType: MTDeviceType.iPhone, desc: "iPhone X", phoneType: .iPhoneX)
        let iPhone10_6 = MTPhoneModel(platform: "iPhone10_6", deviceType: MTDeviceType.iPhone, desc: "iPhone X", phoneType: .iPhoneX)

        let iPod1_1 = MTDeviceModel(platform: "iPod1,1", deviceType: MTDeviceType.iPod, desc: "iPod touch")
        let iPod2_1 = MTDeviceModel(platform: "iPod2,1", deviceType: MTDeviceType.iPod, desc: "iPod touch (2nd generation)")
        let iPod3_1 = MTDeviceModel(platform: "iPod3,1", deviceType: MTDeviceType.iPod, desc: "iPod touch (3rd generation)")
        let iPod4_1 = MTDeviceModel(platform: "iPod4,1", deviceType: MTDeviceType.iPod, desc: "iPod touch (4th generation)")
        let iPod5_1 = MTDeviceModel(platform: "iPod5,1", deviceType: MTDeviceType.iPod, desc: "iPod touch (5th generation)")
        let iPod7_1 = MTDeviceModel(platform: "iPod7,1", deviceType: MTDeviceType.iPod, desc: "iPod touch (6th generation)")

        return [i386, x86_64, airPods, appleTV2_1, appleTV3_1, appleTV3_2, appleTV5_3, appleTV6_2, watch1_1, watch1_2, watch2_6, watch2_7, watch2_3, watch2_4, watch3_1, watch3_2, watch3_3, watch3_4, homePod, iPad1_1, iPad2_1, iPad2_2, iPad2_3, iPad2_4, iPad3_1, iPad3_2, iPad3_3, iPad3_4, iPad3_5, iPad3_6, iPad4_1, iPad4_2, iPad4_3, iPad5_3, iPad5_4, iPad6_7, iPad6_8, iPad6_3, iPad6_4, iPad6_11, iPad6_12, iPad7_1, iPad7_2, iPad7_3, iPad7_4, iPad2_5, iPad2_6, iPad2_7, iPad4_4, iPad4_5, iPad4_6, iPad4_7, iPad4_8, iPad4_9, iPad5_1, iPad5_2, iPhone1_1, iPhone1_2, iPhone2_1, iPhone3_1, iPhone3_2, iPhone4_1, iPhone5_1, iPhone5_2, iPhone5_3, iPhone5_4, iPhone6_1, iPhone6_2, iPhone7_1, iPhone7_2, iPhone8_1, iPhone8_2, iPhone8_4, iPhone9_1, iPhone9_3, iPhone9_2, iPhone9_4, iPhone10_1, iPhone10_4, iPhone10_2, iPhone10_5, iPhone10_3, iPhone10_6, iPod1_1, iPod2_1, iPod3_1, iPod4_1, iPod5_1, iPod7_1]
    }
}
