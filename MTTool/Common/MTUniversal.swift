//
//  MTUniversal.swift
//  MT_Swift_Tool
//
//  Created by ManThirty on 2017/3/15.
//  Copyright © 2017年 ManThirty All rights reserved.
//

import UIKit

// MARK:- 屏幕相关
/** 屏幕宽度 */
let MTScreenWidth = UIScreen.main.bounds.size.width
/** 屏幕高度 */
let MTScreenHeight = UIScreen.main.bounds.size.height
/** 屏幕尺寸 */
let MTScreenBounds = UIScreen.main.bounds
/** 是否是Retina屏 */
let MTisRetina = UIScreen.main.scale > 1 ? true : false

// MARK:- APP相关
/** 命名空间 */
let MTAppNameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
/** App名称 */
let MTAppName = Bundle.main.infoDictionary?["CFBundleName"] as! String
/** App版本号 */
let MTAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
/** App Build号 */
let MTAppBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
/** App URLTypes */
let MTAppURLTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"]
/** 版本号对比 */
let MTVersionCompare = { (currentVersion: String, compareVersion: String) -> ComparisonResult in
    return currentVersion.compare(compareVersion, options: String.CompareOptions.numeric)
}
/** 判断当前版本是否在指定版本之后，包含指定版本 */
let MTVersionAfter = { (_ compareVersion: String) -> Bool in
    return MTVersionCompare(MTAppVersion, compareVersion) == .orderedAscending || MTVersionCompare(MTAppVersion, compareVersion) == .orderedSame
}
/** 判断当前版本是否在指定版本之前，不包含指定版本 */
let MTVersionBefore = { (_ compareVersion: String) -> Bool in
    return MTVersionCompare(MTAppVersion, compareVersion) == .orderedDescending
}

// MARK:- 设备相关
/** 系统名称 */
let MTSystemName = UIDevice.current.systemName
/** 系统版本 */
let MTSystemVersion = UIDevice.current.systemVersion
/** 系统Model */
let MTSystemModel = UIDevice.current.model
/** 系统UUID */
let MTSystemUUID = UIDevice.current.identifierForVendor?.uuidString


// MARK:- 沙盒相关
/** Home目录 */
let MTHomeDirectoryPath = NSHomeDirectory()
/** Documents目录 */
let MTDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
/** Libraty目录 */
let MTLibratyPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
/** Cache目录 */
let MTCachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
/** Temp目录 */
let MTTempPath = NSTemporaryDirectory()


// MARK:- 系统相关
/** 系统信息 */
var MTProcessInfo: ProcessInfo { return ProcessInfo.processInfo }
/** 系统运行时间 */
var MTSystemUpTime: TimeInterval { return MTProcessInfo.systemUptime }
/** 进程环境参数 */
var MTProcessEnvironment: [String : String] { return MTProcessInfo.environment }
/** 主机名 */
var MTHostName: String { return MTProcessInfo.hostName }
/** 进程名称 */
var MTProcess0Name: String { return MTProcessInfo.processName }
/** 进程唯一标识符 */
var MTProcessIdentifier: Int32 { return MTProcessInfo.processIdentifier }
/** 全球唯一码，每次调用都不一样 */
var MTGloballyUniqueString: String { return MTProcessInfo.globallyUniqueString }
/** 操作系统版本号：字符串形式 */
var MTOperatingSystemVersionString: String { return MTProcessInfo.operatingSystemVersionString }
/** 操作系统版本 */
var MTOperatingSystemVersion: OperatingSystemVersion { return MTProcessInfo.operatingSystemVersion }
/** 当前总进程数 */
var MTProcessorCount: Int { return MTProcessInfo.processorCount }
/** 当前激活的总进程数 */
var MTActiveProcessorCount: Int {
    return MTProcessInfo.activeProcessorCount
}
/** 设备物理内存 */
var MTPhysicalMemory: UInt64 { return MTProcessInfo.physicalMemory }
/** 当前操作系统版本是否大于指定版本 */
let MTIsOperatingSystemAtLeast: (OperatingSystemVersion) -> Bool = { (systemVersion) -> Bool in
    return MTProcessInfo.isOperatingSystemAtLeast(systemVersion)
}


/// MARK: - 同步锁
/// 同步锁
///
/// - Parameters:
///   - token: 唯一标识
///   - block: 代码块
public func MTSynchoronized(token: Any? = nil, block: ()->Void) {
    let realToken: Any = token ?? MTGloballyUniqueString
    objc_sync_enter(realToken)
    defer {
        objc_sync_exit(realToken)
    }
    block()
}
