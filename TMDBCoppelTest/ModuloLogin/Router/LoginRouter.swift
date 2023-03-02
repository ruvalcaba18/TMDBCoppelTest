//  LoginRouter.swift
//  TMDBCoppelTest
//  Created by Jael  on 28/02/23.


import Foundation
import UIKit
public class LoginRouter: LoginPresenterToRouter {
   
    var view: UIViewController?
    public static func createLoginModule() -> UIViewController{
        
        let view =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        router.view = view
        
        view?.navigationController?.navigationBar.backgroundColor = .darkGray
        view?.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    
        return view ?? UIViewController()
    }
   

}
