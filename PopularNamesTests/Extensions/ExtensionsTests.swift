//
//  DateTests.swift
//  PopularNames
//
//  Created by Caio Cezar Lopes dos Santos on 3/20/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import XCTest
@testable import PopularNames

class ExtensionsTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFormatInvalidStringShouldReturnNil() {
        let invalidDateString = "TEST"
        let formattedDate = invalidDateString.dateFromISO8601
        
        XCTAssertNil(formattedDate)
    }
    
    func testFormatValidStringShouldReturnAISODate() {
        let dateString = "1969-05-27T00:00:00Z"
        let formattedDate = dateString.dateFromISO8601
        
        XCTAssert(formattedDate != nil)
    }
    
    func testFormatValidStringShouldReturnADefaultFormatDate() {
        let dateString = "22/09/1986"
        let formattedDate = dateString.date
        
        XCTAssert(formattedDate != nil)
        XCTAssert(formattedDate?.defaultFormat == dateString)
    }
    
    func testDateFormattedAsDefaultDateShoulbBeEqualExpected() {
        let date = Date()
        let formattedString = date.defaultFormat
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        XCTAssertEqual(formattedString, "\(day > 9 ? "\(day)" : "0\(day)")/\(month > 9 ? "\(month)" : "0\(month)")/\(year)")
    }
    
    func testDateFormattedAsISODateShoulbBeEqualExpected() {
        let date = Date()
        let formattedString = date.iso8601
        
        XCTAssertNotNil(formattedString)
    }
}
