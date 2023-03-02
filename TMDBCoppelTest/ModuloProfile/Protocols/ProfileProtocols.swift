//  ProfileProtocols.swift
//  TMDBCoppelTest
//  Created by Jael  on 28/02/23.

import Foundation

//MARK:  View to Presenter
protocol ProfileViewToPresenter: AnyObject {
    
    var view: ProfilePresenterToView?{get set }
    var interactor:ProfilePresenterToInteractor?{get set}
    var router:ProfilePresenterToRouter?{get set}

   // func getDetailsMovie(idMovie:String)
}

//MARK: Presenter To View
protocol ProfilePresenterToView: AnyObject {
  
}

//MARK: Presenter To Router
protocol ProfilePresenterToRouter: AnyObject {
  
}
//MARK: Presenter To Interactor
protocol ProfilePresenterToInteractor: AnyObject {
  
  
}

//MARK: Interactor to Presenter
protocol ProfileInteractorToPresenter: AnyObject {
    func setInternetError(error: String)

}
