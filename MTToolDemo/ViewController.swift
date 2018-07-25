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
        
        let str1 = "💕 ﻩ ️ ab\nc"
        let str2 = "😂️😂️"
        let str3 = "\(str1)：\(str2)"
        
        let name = "💕 ﻩ ️ 添奶瓶"
        let content = "所有主流浏览器支持"
        let htmlStr: String = "<font size='3' color='#0f0ff0'>\(name)：</font><font size='5' color='#7b7b7c'>\(content)</font>"
        let lb = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
        lb.backgroundColor = UIColor.purple
        lb.textColor = UIColor.white
//        let attrStr1 = try! NSAttributedString(data: htmlStr.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
//        let mAttrStr = NSMutableAttributedString(attributedString: attrStr1)
//        mAttrStr.append(NSAttributedString(string: "222222222222"))
        
        lb.attributedText = htmlStr.htmlAttributedString
        
        lb.backgroundColor = UIColor.yellow
        lb.numberOfLines = 0
        
        self.view.addSubview(lb)
    }
    

}

