//
// MTUserDefaultTests.swift
//
// 日期：2018/7/4.
// 作者：Nolan   

import XCTest
@testable import MTToolDemo

class MTUserDefaultTests: XCTestCase {

    func testUserDefault() {
        UserDefaults.standard["a"] = Date()
        UserDefaults.standard.synchronize()
    }
}
