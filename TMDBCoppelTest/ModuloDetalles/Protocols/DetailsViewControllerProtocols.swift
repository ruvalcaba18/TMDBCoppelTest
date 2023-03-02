//
//  DetailsViewControllerProtocols.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 28/02/23.
//

import Foundation

//MARK:  View to Presenter
protocol DetailsViewToPresenter: AnyObject {
    
    var view: DetailsPresenterToView?{get set }
    var interactor: DetailsPresenterToInteractor?{get set}
    var router: DetailsPresenterToRouter?{get set}
    
    func getMovieOrTVShowDetail(mediaID: Int,isMovieDetails:Bool)
  
}

//MARK: Presenter To View
protocol DetailsPresenterToView: AnyObject {
    func setMovieDetails(_ movieDetails:DetailsMovie)
    func setTvShowDetails(_ tvShowDetails:Show)
}

//MARK: Presenter To Router
protocol DetailsPresenterToRouter: AnyObject {
   
}
//MARK: Presenter To Interactor
protocol DetailsPresenterToInteractor: AnyObject {
    func fetchMovieDetails(movideID: Int)
    func fetchTVShowDetails(tvShowID: Int)
   
}

//MARK:  Interactor to Presenter
protocol DetailsInteractorToPresenter: AnyObject {
    func setMovieDetails(_ movieDetails:DetailsMovie)
    func setTvShowDetails(_ tvShowDetails:Show)
}
