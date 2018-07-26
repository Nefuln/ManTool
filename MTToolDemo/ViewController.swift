//
//  ViewController.swift
//  MTToolDemo
//
//  Created by Nolan on 2018/6/29.
//  Copyright © 2018年 Nolan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = "💕 ﻩ ️ 添奶瓶"
        let content = "所有主流浏览器支持"
        let htmlStr: String = "<font size='3' color='#0f0ff0'>\(name)：</font><font size='5' color='#7b7b7c'>\(content)</font>"
        let lb = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
        lb.backgroundColor = UIColor.purple
        lb.textColor = UIColor.white
        
        lb.attributedText = htmlStr.htmlAttributedString
        
        lb.backgroundColor = UIColor.yellow
        lb.numberOfLines = 0
        
        self.view.addSubview(lb)
        
        Timer.runThisEvery(seconds: 1) { (timer) in
            debugPrint("进程当前使用内存 = \(UIDevice.current.useMemory ?? 0)b")
        }
    }

}

