//
//  MTDeviceTests.swift
//  MTToolDemoTests
//
//  Created by Nolan on 2018/6/29.
//  Copyright © 2018年 Nolan. All rights reserved.
//

import XCTest
@testable import MTToolDemo

class MTDeviceTests: XCTestCase {
    func testDeviceInfo() {
        let deviceType = UIDevice.current.deviceType
        let deviceModel = UIDevice.current.deviceModel
        let platform = UIDevice.current.platform
        let platformStr = UIDevice.current.platformDesc
        let isPhone = UIDevice.current.isPhone
        let phoneType = UIDevice.current.iPhoneType
        debugPrint("设备类型：\(deviceType)\n设备系统平台：\(platform)\n平台描述：\(platformStr)\n是否是手机：\(isPhone ? "是" : "否")\n手机型号：\(phoneType)")
        XCTAssert(deviceModel != nil, "无法获取设备信息")
    }
}
