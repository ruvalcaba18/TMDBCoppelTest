//
//  DetailsPresenter.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 28/02/23.
//

import Foundation

class DetailsPresenter : DetailsViewToPresenter {
   
    var view: DetailsPresenterToView?
    var interactor: DetailsPresenterToInteractor?
    var router: DetailsPresenterToRouter?
    
    func getMovieOrTVShowDetail(mediaID: Int, isMovieDetails: Bool) {
        if !isMovieDetails{
            interactor?.fetchTVShowDetails(tvShowID: mediaID)
        }
        interactor?.fetchMovieDetails(movideID: mediaID)
    }

}

extension DetailsPresenter:DetailsInteractorToPresenter {
   
    
    func setTvShowDetails(_ tvShowDetails: Show) {
        view?.setTvShowDetails(tvShowDetails)
    }
    
    func setMovieDetails(_ movieDetails: DetailsMovie) {
        view?.setMovieDetails(movieDetails)
    }

}
