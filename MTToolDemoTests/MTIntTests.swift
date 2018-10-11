//
// MTIntTests.swift
//
// 日期：2018/10/11.
// 作者：Nolan   

import XCTest
@testable import MTToolDemo

class MTIntTests: XCTestCase {
    func testInt() {
        for j in -100...100000 {
            if j.isPrime {
                debugPrint("\(j)是素数")
            }
        }

    }
}
