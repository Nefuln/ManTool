//
// MTStringTests.swift
//
// 日期：2018/7/3.
// 作者：Nolan   

import XCTest
@testable import MTToolDemo

class MTStringTests: XCTestCase {
    
    func testString() {
        let str = "afadsfdsfjdslofjlasdfjsd fjlajsfjklsjdflajsdfalsdjfdlsj"
        XCTAssert(str[0..<10] == "afadsfdsfj")
        XCTAssert(str[15] == "j")
        XCTAssert(str.count("a") == 6)
    }

}
