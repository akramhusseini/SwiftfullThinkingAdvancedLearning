//
//  UITestingBootcampView_UITests.swift
//  SwiftfullThinkingAdvancedLearning_UITests
//
//  Created by Akram Husseini on 02/07/2025.
//

import XCTest


// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming structure: test_[struct]_[[ui component]_[expected result]
// Testing Structure: Given, WHen, Then


class UITestingBootcampView_UITests: XCTestCase {

    
    let app =  XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
     
    }
    
    func test_UITestingBootcampView_SignupButton_ShouldNotSignIn() {
        // Given
        let textField = app.textFields["Add your name..."]
        // When
        textField.tap()
        let keyA = app.keys["A"]
        XCTAssertTrue(keyA.waitForExistence(timeout: 2))
        keyA.tap()
        keyA.tap()
        keyA.tap()
        
        let returnedButton = app.buttons["Return"]
        returnedButton.tap()
        
        let signupButton = app.buttons["Sign in"]
        signupButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        // Then
        
        XCTAssertTrue(navBar.exists)
        
    }
    
    func test_UITestingBootcampView_SignupButton_ShouldSignIn() {
        
    }

}
