//
//  Currency_ConverterUITests.swift
//  Currency ConverterUITests
//
//  Created by Mohamed Alsadek on 10/31/15.
//  Copyright © 2015 Mohamed Alsadek. All rights reserved.
//

import XCTest

class Currency_ConverterUITests: XCTestCase {
        
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
    /*
    - this test case check when the user change the input value of AUD and check if the result label value changed.
    */
    func testCase1() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let textField = XCUIApplication().childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.TextField).element
        textField.tap()
        textField.typeText("999")
        
        //if the result label still have the inital text $0.00 after changing the value to 999 this mean the test fail 
        //if the value changed this mean it worked.
        let StaticText = XCUIApplication().staticTexts["$0.00"]
        assert(!StaticText.exists)
        
    }
    
}
