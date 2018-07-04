//
// MTUIViewControllerTests.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import XCTest
@testable import MTToolDemo

class MTUIViewControllerTests: XCTestCase {
    
    func testUIViewController() {
        XCTAssert(UIViewController.current?.className == ViewController.className)
    }

}
