//
//  LoginUnitTests.swift
//  TMDBCoppelTestTests
//
//  Created by Jael  on 28/02/23.
//

import XCTest

final class LoginUnitTests: XCTestCase {
    
    var sut: ViewController!
    
    override func setUp() {
        super.setUp()
        sut = ViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testUsernameTextFieldNotNil() {
        XCTAssertNotNil(sut.usernameTextField)
    }
    
    func testPasswordTextFieldNotNil() {
        XCTAssertNotNil(sut.passwordTextField)
    }
    
    func testMrRobotImageNotNil() {
        XCTAssertNotNil(sut.mrRobotImage)
    }
    
    func testLoginButtonNotNil() {
        XCTAssertNotNil(sut.loginButton)
    }
    
    func testErrorLabelNotNil() {
        XCTAssertNotNil(sut.errorLabel)
    }
    
    func testActivityIndicatorViewNotNil() {
        XCTAssertNotNil(sut.activityIndicatorView)
    }
    
    func testOwnerViewNotNil() {
        XCTAssertNotNil(sut.ownerView)
    }
    
    func testVCNotNil() {
        XCTAssertNotNil(sut.vc)
    }
    
    func testPasswordToggleIconNotNil() {
        XCTAssertNotNil(sut.passwordToggleIcon)
    }
    
    func testTogglePasswordVisibility() {
        let initialSecureTextEntryValue = sut.passwordTextField.isSecureTextEntry
        sut.togglePasswordVisibility(sender: sut.passwordToggleIcon)
        XCTAssertNotEqual(sut.passwordTextField.isSecureTextEntry, initialSecureTextEntryValue)
    }
    
    
    func testLoginButtonTappedWithIncorrectCredentials() {
        sut.usernameTextField.text = "foo"
        sut.passwordTextField.text = "bar"
        sut.loginButtonTapped()
        
        let expectation = XCTestExpectation(description: "Shows error message")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if self.sut.errorLabel.text == "Incorrect username or password" {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 25)
    }
    
}
