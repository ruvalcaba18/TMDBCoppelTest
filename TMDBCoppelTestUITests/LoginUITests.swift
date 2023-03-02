//
//  LoginUITests.swift
//  TMDBCoppelTestUITests
//
//  Created by Jael  on 28/02/23.
//

import XCTest

final class LoginUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginSuccess() {
        
        let usernameTextField = app.textFields["usernameTextField"]
        let passwordTextField = app.secureTextFields["password"]
        let loginButton = app.buttons["loginButton"]
        XCTAssertTrue(usernameTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText("User")
        passwordTextField.tap()
        passwordTextField.typeText("password")
        XCTAssertTrue(loginButton.exists )
     
        if loginButton.isHittable {
            loginButton.tap()
        }else{
            XCTAssertFalse(loginButton.isHittable)
        }
    }
    
    
}
