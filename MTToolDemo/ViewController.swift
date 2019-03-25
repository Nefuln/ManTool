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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        self.inputTF.center = self.view.center
        self.view.addSubview(self.inputTF)
    }
    
    fileprivate lazy var inputTF: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        tf.delegate = self
        return tf
    }()
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}


