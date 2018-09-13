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
let MTProcessInfo: ProcessInfo = ProcessInfo.processInfo
/** 系统运行时间 */
let MTSystemUpTime: TimeInterval = MTProcessInfo.systemUptime
/** 进程环境参数 */
let MTProcessEnvironment: [String : String] = MTProcessInfo.environment
/** 主机名 */
let MTHostName: String = MTProcessInfo.hostName
/** 进程名称 */
let MTProcess0Name: String = MTProcessInfo.processName
/** 进程唯一标识符 */
let MTProcessIdentifier: Int32 = MTProcessInfo.processIdentifier
/** 全球唯一码，每次调用都不一样 */
let MTGloballyUniqueString: String = MTProcessInfo.globallyUniqueString
/** 操作系统版本号：字符串形式 */
let MTOperatingSystemVersionString: String = MTProcessInfo.operatingSystemVersionString
/** 操作系统版本 */
let MTOperatingSystemVersion: OperatingSystemVersion = MTProcessInfo.operatingSystemVersion
/** 当前总进程数 */
let MTProcessorCount: Int = MTProcessInfo.processorCount
/** 当前激活的总进程数 */
let MTActiveProcessorCount: Int = MTProcessInfo.activeProcessorCount
/** 设备物理内存 */
let MTPhysicalMemory: UInt64 = MTProcessInfo.physicalMemory
/** 当前操作系统版本是否大于指定版本 */
let MTIsOperatingSystemAtLeast: (OperatingSystemVersion) -> Bool = { (systemVersion) -> Bool in
    return MTProcessInfo.isOperatingSystemAtLeast(systemVersion)
}
