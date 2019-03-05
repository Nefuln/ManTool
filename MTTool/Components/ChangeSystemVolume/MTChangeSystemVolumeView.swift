//
//  MTChangeSystemVolumeView.swift
//  MTToolDemo
//
//  Created by ManThirty on 2019/3/4.
//  Copyright © 2019 Nolan. All rights reserved.
//

import UIKit
import MediaPlayer

class MTChangeSystemVolumeView: UIView {
    
    convenience init(frame: CGRect, showSystemAlert: Bool = false) {
        self.init(frame: frame)
        self.showSystemAlert = showSystemAlert
        self.setupUI()
        self.addObservers()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.removeAllObservers()
    }
    
    var currentSystemVolume: Float {
        return self.customVolumeSlide.value
    }
    
    var customVolumeSlide: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(MTChangeSystemVolumeView.handleSliderValueChange(_:)), for: UIControlEvents.valueChanged)
        return slider
    }()
    
    lazy var volumeView: MPVolumeView = {
        let view = MPVolumeView()
        return view
    }()
    
    fileprivate var showSystemAlert: Bool = false
    fileprivate var systemVolumeSlide: UISlider?
}

// MARK: - Api
extension MTChangeSystemVolumeView {
    func turnUpVolume(to value: Float) {
        var tmpValue = value
        if tmpValue < 0 {
            tmpValue = 0
        } else if tmpValue > 1 {
            tmpValue = 1
        }
        self.systemVolumeSlide?.setValue(tmpValue, animated: false)
        self.systemVolumeSlide?.sendActions(for: UIControlEvents.valueChanged)
    }
}

// MARK: - UI
extension MTChangeSystemVolumeView {
    fileprivate func setupUI() {
        for subview in self.volumeView.subviews {
            if subview is UISlider {
                self.systemVolumeSlide = (subview as? UISlider)
                break
            }
        }
        if self.showSystemAlert {
            self.customVolumeSlide.frame = self.bounds
            self.customVolumeSlide.value = AVAudioSession.sharedInstance().outputVolume
            self.addSubview(self.customVolumeSlide)
            return
        }
        self.volumeView.frame = self.bounds
        self.addSubview(self.volumeView)
    }
}

// MARK: - Action
extension MTChangeSystemVolumeView {
    @objc fileprivate func handleSliderValueChange(_ sender: UISlider) {
        self.systemVolumeSlide?.setValue(sender.value, animated: false)
        self.systemVolumeSlide?.sendActions(for: UIControlEvents.valueChanged)
    }
}

// MARK: - Observer
extension MTChangeSystemVolumeView {
    fileprivate func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(MTChangeSystemVolumeView.handleSystemVolumeChangeNotification(_:)), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
    }
    
    fileprivate func removeAllObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleSystemVolumeChangeNotification(_ noti: Notification) {
        if self.customVolumeSlide.isTouchInside { return }
        guard let volume: Float = noti.userInfo?["AVSystemController_AudioVolumeNotificationParameter"] as? Float else { return }
        self.customVolumeSlide.setValue(volume, animated: true)
    }
}
