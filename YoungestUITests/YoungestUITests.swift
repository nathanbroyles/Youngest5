//
//  YoungestUITests.swift
//  YoungestUITests
//
//  Created by Nathan Broyles on 12/8/19.
//  Copyright © 2019 DeadPixel. All rights reserved.
//

import XCTest

class YoungestUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDisplay5Youngest() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // wait for a table view cell to appear
        let _ = app.tables.firstMatch.cells.firstMatch.waitForExistence(timeout: 10)
        XCTAssert(app.tables.firstMatch.cells.count == 5)
    }
}
