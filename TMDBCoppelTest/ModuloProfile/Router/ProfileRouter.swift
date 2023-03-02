//
//  ProfileRouter.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 28/02/23.

import Foundation
import UIKit
public class ProfileRouter: ProfilePresenterToRouter
{
   
    var view: UIViewController?
    
    public static func createProfileModule() -> UIViewController{
        
        let view =  ProfileViewController()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        router.view = view

        view.presenter = presenter
        presenter.view = view as? any ProfilePresenterToView 
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    
        return view
    }
    

}
