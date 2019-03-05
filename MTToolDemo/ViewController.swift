//
//  ViewController.swift
//  MTToolDemo
//
//  Created by Nolan on 2018/6/29.
//  Copyright © 2018年 Nolan. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController {
    
    fileprivate let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    
    lazy var btn1: UIButton = {
        let btn = UIButton(frame: CGRect(x: 50, y: 100, width: 150, height: 50))
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn.setTitle("调高", for: .normal)
        btn.addTarget(self, action: #selector(ViewController.handleAction1), for: UIControlEvents.touchUpInside)
        return btn
    }()

    @objc private func handleAction1() {
//        self.slider?.setValue(self.slider!.value + 1/16, animated: false)
//        self.slider?.sendActions(for: UIControlEvents.touchUpInside)
//        debugPrint("AVAudioSession.sharedInstance().accessibilityActivate() == \(AVAudioSession.sharedInstance().accessibilityActivate())")
//        debugPrint("self.slider == \(self.slider), value == \(self.slider?.value)")
        
        self.mtVolumeView.turnUpVolume(to: self.mtVolumeView.currentSystemVolume + 1/16)

    }
    
    lazy var btn2: UIButton = {
        let btn = UIButton(frame: CGRect(x: 50, y: 200, width: 150, height: 50))
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn.setTitle("调低", for: .normal)
        btn.addTarget(self, action: #selector(ViewController.handleAction2), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    @objc private func handleAction2() {
        self.mtVolumeView.turnUpVolume(to: self.mtVolumeView.currentSystemVolume - 1/16)
    }
    
    fileprivate let mtVolumeView = MTChangeSystemVolumeView(frame: CGRect(x: 50, y: 300, width: 150, height: 50), showSystemAlert: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        
        self.view.addSubview(mtVolumeView)
        
//        let myVolumeView = MPVolumeView(frame: CGRect(x: 50, y: 300, width: 150, height: 50))
//        for subview in myVolumeView.subviews {
//            if subview is UISlider {
//                self.slider = subview as! UISlider
//                debugPrint("self.slider == \(self.slider), value == \(self.slider?.value)")
//                break
//            }
//        }
//        self.view.addSubview(myVolumeView)
//
        self.view.addSubview(self.btn1)
        self.view.addSubview(self.btn2)
        
//        self.addBtns()
//        self.convertViewToImage()
//        btn.setTitle("测试", for: UIControlState.normal)
//        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
//        btn.center = self.view.center
//        btn.tapBlock = { (b) in
//            debugPrint(Date().timeIntervalSince1970)
//        }
//        btn.allowRepeat = false
//        btn.repeatClickInterval = 1
//        btn.minClickArea = CGSize(width: 100, height: 50)
//        self.view.addSubview(btn)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.convertViewToImage()
//        btn.allowRepeat = !btn.allowRepeat
//        debugPrint(MT_classNameFromObject(self))
//        debugPrint(MTGloballyUniqueString)
//    }
    
    @objc private func handleScreenNotification() {
        debugPrint("是否是x系列 == \(MTIsIPhoneX)")
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


