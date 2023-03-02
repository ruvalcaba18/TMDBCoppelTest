//  LoginInteractor.swift
//  TMDBCoppelTest
//  Created by Jael  on 28/02/23.
import Foundation

class LoginInteractor: LoginPresenterToInteractor {
    
    // MARK: - Properties
    var presenter: LoginInteractorToPresenter?
    
    // MARK: - Public methods
    func verifyInformation(_ username: String, _ password: String) {
        
        let isUsernameValid = username == "User"
        let isPasswordValid = password == "password"
        
        if isUsernameValid && isPasswordValid {
            self.presenter?.setIsUsernameAndPasswordValid(true, true)
        } else if isUsernameValid {
            self.presenter?.setIsUsernameAndPasswordValid(true, false)
        } else if isPasswordValid {
            self.presenter?.setIsUsernameAndPasswordValid(false, true)
        } else {
            self.presenter?.setIsUsernameAndPasswordValid(false, false)
        }
    }
    
}
