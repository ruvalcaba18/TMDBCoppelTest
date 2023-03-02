//
//  LoginProtocols.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 28/02/23.

import Foundation

//MARK: View to Presenter
protocol LoginViewToPresenter: AnyObject {
    
    var view: LoginPresenterToView?{get set }
    var interactor:LoginPresenterToInteractor?{get set}
    var router:LoginPresenterToRouter?{get set}
    
    func isUsernameAndPasswordValid(_ username:String, _ password:String)
}

//MARK: Presenter To View
protocol LoginPresenterToView: AnyObject {
    func setIsUsernameAndPasswordValid(_ correctUser: Bool, _ correctPassword:Bool)
}

//MARK: Presenter To Router
protocol LoginPresenterToRouter: AnyObject {
}
//MARK: Presenter To Interactor
protocol LoginPresenterToInteractor: AnyObject {
    func verifyInformation(_ username:String, _ password:String)
  
}

//MARK:  Interactor to Presenter
protocol LoginInteractorToPresenter: AnyObject {
    func setIsUsernameAndPasswordValid(_ correctUser: Bool, _ correctPassword:Bool)
}
