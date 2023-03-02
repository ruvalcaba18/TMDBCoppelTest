//
//  TMDBProtocols.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation

//MARK:  View to Presenter
protocol MovieViewToPresenter: AnyObject {
    
    var view: MoviePresenterToView?{get set }
    var interactor:MoviePresenterToInteractor?{get set}
    var router:MoviePresenterToRouter?{get set}
    
    func getPopularMovies(pages:String)
    func getTopRate(page:String)
    func getOnTv(page:String)
    func getAiringToday(page:String)
}

//MARK: Presenter To View
protocol MoviePresenterToView: AnyObject {
    func onResponseError(error:String)
    func setPopularMovies(movies:[MovieResponse])
    func setTopRated(movies:[MovieResponse])
    func setOnTv(tvShows:[TVShow])
    func setAiringToday(tvShows:[TVShow])
}

//MARK: Presenter To Router
protocol MoviePresenterToRouter: AnyObject {
    func moveToMovieDetail(movieId:Int,isShowingMoviesDetails:Bool)
    func moveToProfile() -> ProfileViewController
    func moveToLogin()
}
//MARK: Presenter To Interactor
protocol MoviePresenterToInteractor: AnyObject {
    
    func fetchPopularMovieList(page:String)
    func fetchTopRated(page:String)
    func fetchOnTV(page:String)
    func fetchAiringToday(page:String)
    
}

//MARK:  Interactor to Presenter
protocol MovieInteractorToPresenter: AnyObject {
    func setInternetError(error: String)
    func setPopularMovies(movies: [MovieResponse])
    func setTopRated(movies:[MovieResponse])
    func setOnTv(tvShows:[TVShow])
    func setAiringToday(tvShows:[TVShow])
}
