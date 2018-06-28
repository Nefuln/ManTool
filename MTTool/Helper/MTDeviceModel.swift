//
//  UIDeviceModel.swift
//  MTToolDemo
//
//  Created by Nolan on 2018/6/29.
//  Copyright © 2018年 Nolan. All rights reserved.
//

import UIKit

enum MTDeviceType: UInt {
    case None = 0
    case Simulator
    case AirPods
    case AppleTV
    case Watch
    case HomePod
    case iPad
    case iPadMini
    case iPhone
    case iPod
}

enum MTPhoneDeviceType: UInt {
    case None = 0
    case Simulator
    case iPhone1G
    case iPhone3G
    case iPhone3GS
    case iPhone4
    case iPhone4S
    case iPhone5
    case iPhone5C
    case iPhone5S
    case iPhoneSE
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6SPlus
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
}

class MTDeviceModel: NSObject {
    var platform: String
    var deviceType: MTDeviceType = MTDeviceType.None
    var desc: String
    
    init(platform: String, deviceType: MTDeviceType, desc: String) {
        self.platform = platform
        self.deviceType = deviceType
        self.desc = desc
        super.init()
    }
}

class MTPhoneModel: MTDeviceModel {
    var phoneType: MTPhoneDeviceType
    init(platform: String, deviceType: MTDeviceType, desc: String, phoneType: MTPhoneDeviceType) {
        self.phoneType = phoneType
        super.init(platform: platform, deviceType: deviceType, desc: desc)
    }
}
