//
//  PopularNamesUITests.swift
//  PopularNamesUITests
//
//  Created by Caio Cezar Lopes dos Santos on 3/19/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import XCTest

class PopularNamesUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNavigationBarsTitles() {
        if UI_USER_INTERFACE_IDIOM() != .pad {
            validateNavigationBarsTitles()
        } 
    }
    
    func validateNavigationBarsTitles() {
        let app = XCUIApplication()

        let persons = ["Steve Jobs", "Craig Federighi", "Jonathan Ive", "Timothy Cook", "William Henry Gates", "Scott Forstall"]
        
        for item in persons {
            let cell = getCell(identifier: item)
            if cell.staticTexts[item].exists {
                cell.staticTexts["Birthday:"].tap()
                XCTAssert(app.navigationBars[item].exists)
                tapBackNavBar(identifier: item)
            }
        }
        
    }
    
    func getCell(identifier: String) -> XCUIElementQuery {
        return XCUIApplication().tables.cells.containing(.staticText, identifier: identifier)
    }
    
    func tapBackNavBar(identifier: String) {
        XCUIApplication().navigationBars[identifier].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
    }
}
