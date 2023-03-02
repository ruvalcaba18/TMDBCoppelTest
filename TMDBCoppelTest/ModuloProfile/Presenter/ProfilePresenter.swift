//
//  ProfilePresenter.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 28/02/23.
//

import Foundation

class ProfilePresenter:ProfileViewToPresenter{
 
    var view: ProfilePresenterToView?
    var interactor: ProfilePresenterToInteractor?
    var router: ProfilePresenterToRouter?
    
 
    
}

extension ProfilePresenter: ProfileInteractorToPresenter{
    
    func setInternetError(error: String) {
    
    }
 
}
