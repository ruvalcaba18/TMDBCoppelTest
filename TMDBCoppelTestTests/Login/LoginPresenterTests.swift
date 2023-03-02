//  LoginPresenterTests.swift
//  TMDBCoppelTestTests
//  Created by Jael  on 01/03/23.

import XCTest

// MockLoginInteractor is defined here
class MockLoginInteractor: LoginPresenterToInteractor {
    var verifyInformationCallback: ((String, String) -> Void)?

    func verifyInformation(_ username: String, _ password: String) {
        verifyInformationCallback?(username, password)
    }
}



final class LoginPresenterTests: XCTestCase {

    func testIsUsernameAndPasswordValid() {
           let presenter = LoginPresenter()
           let interactor = MockLoginInteractor()
           presenter.interactor = interactor

           let expectation = XCTestExpectation(description: "Verify information")

           interactor.verifyInformationCallback = { username, password in
               XCTAssertEqual(username, "john.doe")
               XCTAssertEqual(password, "password")
               expectation.fulfill()
           }

           presenter.isUsernameAndPasswordValid("john.doe", "password")
           wait(for: [expectation], timeout: 1.0)
       }

}
