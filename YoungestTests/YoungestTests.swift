//
//  YoungestTests.swift
//  YoungestTests
//
//  Created by Nathan Broyles on 12/8/19.
//  Copyright © 2019 DeadPixel. All rights reserved.
//

import XCTest
@testable import Youngest

class YoungestTests: XCTestCase {
    
    let validUser = User(id: 0, name: "Valid", age: 21, number: "1234567890", photo: "", bio: "")
    let invalidUser = User(id: 1, name: "Invalid", age: 23, number: "123", photo: "", bio: "")
    let model = Model()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model.users = [
            User(id: 0, name: "", age: 9, number: "", photo: "", bio: ""),
            User(id: 1, name: "", age: 8, number: "", photo: "", bio: ""),
            User(id: 2, name: "", age: 7, number: "", photo: "", bio: ""),
            User(id: 3, name: "", age: 6, number: "", photo: "", bio: ""),
            User(id: 4, name: "", age: 5, number: "", photo: "", bio: ""),
            User(id: 5, name: "", age: 4, number: "", photo: "", bio: ""),
            User(id: 6, name: "", age: 3, number: "", photo: "", bio: ""),
            User(id: 7, name: "", age: 2, number: "", photo: "", bio: "")
        ]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test5Youngest() {
        let youngest = model.youngestUsers(5)
        let youngestAgeSum = youngest?.reduce(0, {$0 + $1.age})
        let testAgeSum = 20
        XCTAssert(testAgeSum == youngestAgeSum)
    }

    func testValidUser() {
        XCTAssert(validUser.isValid() == true)
        XCTAssert(invalidUser.isValid() == false)
    }
}
