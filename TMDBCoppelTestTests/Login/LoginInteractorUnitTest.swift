//  LoginInteractorUnitTest.swift
//  TMDBCoppelTestTests
//  Created by Jael  on 28/02/23.

import XCTest

final class LoginInteractorUnitTest: XCTestCase {
      
      override func setUp() {
          super.setUp()
    
      }
      
      override func tearDown() {
          super.tearDown()
      }
      
    func testVerifyInformation() {
          let mockPresenter = MockLoginInteractorToPresenter()
          let interactor = LoginInteractor()
          interactor.presenter = mockPresenter
          
          interactor.verifyInformation("User", "password")
          XCTAssertTrue(mockPresenter.isUsernameAndPasswordValidParam.0)
          XCTAssertTrue(mockPresenter.isUsernameAndPasswordValidParam.1)

          interactor.verifyInformation("User", "wrong_password")
          XCTAssertTrue(mockPresenter.isUsernameAndPasswordValidParam.0)
          XCTAssertFalse(mockPresenter.isUsernameAndPasswordValidParam.1)

          interactor.verifyInformation("Wrong_username", "password")
          XCTAssertFalse(mockPresenter.isUsernameAndPasswordValidParam.0)
          XCTAssertTrue(mockPresenter.isUsernameAndPasswordValidParam.1)

          interactor.verifyInformation("Wrong_username", "wrong_password")
          XCTAssertFalse(mockPresenter.isUsernameAndPasswordValidParam.0)
          XCTAssertFalse(mockPresenter.isUsernameAndPasswordValidParam.1)
      }
     
     
}

class MockLoginInteractorToPresenter: LoginInteractorToPresenter {
    
    var isUsernameAndPasswordValidParam: (correctUser: Bool, correctPassword: Bool) = (false, false)

    func setIsUsernameAndPasswordValid(_ correctUser: Bool, _ correctPassword: Bool) {
        isUsernameAndPasswordValidParam = (correctUser, correctPassword)
    }
}
