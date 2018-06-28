//
//  MTUniversal.swift
//  MT_Swift_Tool
//
//  Created by jwn on 2017/3/15.
//  Copyright © 2017年 jwn. All rights reserved.
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


// MARK:- 设备相关

/** 系统名称 */
let MTSystemName = UIDevice.current.systemName
/** 系统版本 */
let MTSystemVersion = UIDevice.current.systemVersion
/** 系统Model */
let MTSystemModel = UIDevice.current.model
/** 系统UUID */
let MTSystemUUID = UIDevice.current.identifierForVendor?.uuidString

