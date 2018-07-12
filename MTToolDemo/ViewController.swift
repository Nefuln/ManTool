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
        
        let imgView1 = UIImageView(frame: CGRect(x: 100, y: 30, width: 100, height: 100))
        imgView1.image = UIImage(named: "myYellowSearch")?.corner(10, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight])
        imgView1.contentMode = .center
        
        let imgView2 = UIImageView(frame: CGRect(x: 100, y: 150, width: 100, height: 100))
        imgView2.image = UIImage(named: "myYellowSearch")?.scaleTo(rate: 0.5)
        imgView2.contentMode = .center

        let imgView3 = UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        imgView3.image = UIImage(named: "myYellowSearch")?.croppedImage(CGRect(x: 10, y: 10, width: 20, height: 20))
        imgView3.contentMode = .center

        self.view.addSubviews(imgView1, imgView2, imgView3)
    }

}

