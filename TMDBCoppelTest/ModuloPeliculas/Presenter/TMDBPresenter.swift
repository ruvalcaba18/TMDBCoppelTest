//
//  TMDBPresenter.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
class MoviePresenter:MovieViewToPresenter{
 
    var view: MoviePresenterToView?
    var interactor: MoviePresenterToInteractor?
    var router: MoviePresenterToRouter?
    
    func getPopularMovies(pages: String) {
        interactor?.fetchPopularMovieList(page: pages)
    }
    
    func getTopRate(page: String) {
        interactor?.fetchTopRated(page: page)
    }
    
    func getOnTv(page: String) {
        interactor?.fetchOnTV(page: page)
    }
    
    func getAiringToday(page: String) {
        interactor?.fetchAiringToday(page: page)
    }
    
}
extension MoviePresenter: MovieInteractorToPresenter{
    func setPopularMovies(movies: [MovieResponse]) {
        view?.setPopularMovies(movies: movies)
    }
    
    func setTopRated(movies:[MovieResponse]) {
        view?.setTopRated(movies: movies)
    }
    
    func setOnTv(tvShows:[TVShow]) {
        view?.setOnTv(tvShows: tvShows)
    }
    
    func setAiringToday(tvShows:[TVShow]) {
        view?.setAiringToday(tvShows: tvShows)
    }
    
    func setInternetError(error: String) {
        view?.onResponseError(error: error)
    }
    
}
