//  LoginPresenter.swift
//  TMDBCoppelTest
//  Created by Jael  on 28/02/23.


import Foundation
class LoginPresenter: LoginViewToPresenter {
    
    var view: LoginPresenterToView?
    var interactor: LoginPresenterToInteractor?
    var router: LoginPresenterToRouter?
    
    func isUsernameAndPasswordValid(_ username: String, _ password: String) {
        interactor?.verifyInformation(username, password)
    }

}

extension LoginPresenter: LoginInteractorToPresenter {
    
    func setIsUsernameAndPasswordValid(_ correctUser: Bool, _ correctPassword: Bool) {
        view?.setIsUsernameAndPasswordValid(correctUser, correctPassword)
    }

}
