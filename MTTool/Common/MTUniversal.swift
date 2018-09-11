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

