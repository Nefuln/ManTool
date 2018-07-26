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
        let 电池电量 = UIDevice.current.MT_batteryQuantity
        let 电池状态 = UIDevice.current.MT_batteryState
        let 设备总内存 = UIDevice.current.totalMemorySize
        let 设备可用内存 = UIDevice.current.useMemory ?? 0
        let 磁盘总大小 = UIDevice.current.totalDiskSize
        let 磁盘可用空间 = UIDevice.current.availableDiskSize
        debugPrint("设备类型：\(deviceType)")
        debugPrint("设备系统平台：\(platform)")
        debugPrint("平台描述：\(platformStr)")
        debugPrint("是否是手机：\(isPhone ? "是" : "否")")
        debugPrint("手机型号：\(phoneType)")
        debugPrint("电池电量：\(电池电量)")
        debugPrint("电池状态:\(电池状态)")
        let convertCount: Float = Float(1024*1024*1024)
        debugPrint("设备总内存:\(Float(设备总内存)/convertCount)g")
        debugPrint("设备可用内存:\(Float(设备可用内存)/convertCount)g")
        debugPrint("磁盘总大小:\(Float(磁盘总大小)/convertCount)g")
        debugPrint("磁盘可用空间:\(Float(磁盘可用空间)/convertCount)g")
        XCTAssert(deviceModel != nil, "无法获取设备信息")
    }
}
