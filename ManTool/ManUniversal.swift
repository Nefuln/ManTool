//
//  ManUniversal.swift
//  Man_Swift_Tool
//
//  Created by jwn on 2017/3/15.
//  Copyright © 2017年 jwn. All rights reserved.
//

import UIKit

// MARK:- 屏幕相关

/** 屏幕宽度 */
let ManScreenWidth = UIScreen.main.bounds.size.width
/** 屏幕高度 */
let ManScreenHeight = UIScreen.main.bounds.size.height
/** 屏幕尺寸 */
let ManScreenBounds = UIScreen.main.bounds
/** 是否是Retina屏 */
let isRetina = UIScreen.main.scale > 1 ? true : false

// MARK:- APP相关

/** 命名空间 */
let ManAppNameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
/** App名称 */
let ManAppName = Bundle.main.infoDictionary?["CFBundleName"] as! String
/** App版本号 */
let ManAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
/** App Build号 */
let ManAppBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
/** App URLTypes */
let ManAppURLTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"]


// MARK:- 设备相关

/** 系统名称 */
let ManSystemName = UIDevice.current.systemName
/** 系统版本 */
let ManSystemVersion = UIDevice.current.systemVersion
/** 系统Model */
let ManSystemModel = UIDevice.current.model
/** 系统UUID */
let ManSystemUUID = UIDevice.current.identifierForVendor?.uuidString

