// MTNSObjectTests.swift

// 日期：2018/7/3.
// 作者：Nolan   

import XCTest
@testable import MTToolDemo

class MTNSObjectTests: XCTestCase {

    func testObjectClassName() {
        debugPrint(self.className)
        XCTAssertTrue(self.className == "MTNSObjectTests")
    }
    
}
