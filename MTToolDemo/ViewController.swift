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
//        self.addBtns()
        self.convertViewToImage()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.convertViewToImage()
    }
    
    
    private func addAttributedLable() {
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

    private func addBtns() {
        let btn1 = UIButton(type: UIButtonType.custom)
        btn1.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn1.setTitle("测试1", for: UIControlState.normal)
        btn1.frame = CGRect(x: 20, y: 50, width: 100, height: 50)
        btn1.setImage(UIImage(named: "myYellowSearch"), for: UIControlState.normal)
        btn1.layoutButton(style: MTButtonEdgeInsetsStyle.Top, space: 5)
        
        let btn2 = UIButton(type: UIButtonType.custom)
        btn2.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn2.setTitle("测试2", for: UIControlState.normal)
        btn2.frame = CGRect(x: 20, y: 110, width: 100, height: 50)
        btn2.setImage(UIImage(named: "myYellowSearch"), for: UIControlState.normal)
        btn2.layoutButton()

        let btn3 = UIButton(type: UIButtonType.custom)
        btn3.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn3.setTitle("测试3", for: UIControlState.normal)
        btn3.frame = CGRect(x: 20, y: 170, width: 100, height: 50)
        btn3.setImage(UIImage(named: "myYellowSearch"), for: UIControlState.normal)
        btn3.layoutButton(style: .Right, space: 10)

        let btn4 = UIButton(type: UIButtonType.custom)
        btn4.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn4.setTitle("测试4", for: UIControlState.normal)
        btn4.frame = CGRect(x: 20, y: 230, width: 100, height: 50)
        btn4.setImage(UIImage(named: "myYellowSearch"), for: UIControlState.normal)
        btn4.layoutButton(style: .Bottom, space: 40)

        self.view.addSubviews(btn1, btn2, btn3, btn4)
    }

    private func convertViewToImage() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        let subview = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        subview.backgroundColor = UIColor.yellow
        view.addSubview(subview)
        let img = UIImage.image(fromView: view)
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imgView.backgroundColor = UIColor.gray
        imgView.contentMode = .scaleAspectFit
        imgView.center = self.view.center
        imgView.image = img
        self.view.addSubview(imgView)
    }
}


