//
//  DetailsInteractor.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 28/02/23.
//

import Foundation
class DetailsInteractor:DetailsPresenterToInteractor {
    
    // MARK: - Properties
    
    var presenter: DetailsInteractorToPresenter?
    static var sharedURLSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 50
        configuration.timeoutIntervalForResource = 50
        configuration.networkServiceType = .background
        return URLSession(configuration: configuration)
    }()
    var movieTask:URLSessionDataTask?
    var tvTask:URLSessionDataTask?
    var baseMovieURL = ""
    var baseTvURL = ""
    var baseIMDBUrl = ""
    let jsonDecoder = JSONDecoder()
    
    // MARK: - Public methods
    func fetchMovieDetails(movideID: Int) {
        
        guard let movieUrl = URL(string: EndpointCase.detailMovies(environment: baseMovieURL, movieId: "\(movideID)").url) else{return}
        
        let movieTask = DetailsInteractor.sharedURLSession.dataTask(with: movieUrl) { [weak self] (data, response, error) in
            
            guard let data = data else{ return }
            
            if let error = error {
                print("Error fetching movie data: \(error.localizedDescription)")
                
            } else {
                
                do{
                    guard let decodedData = try self?.jsonDecoder.decode(DetailsMovie.self, from: data) else {
                        return
                    }
                    self?.presenter?.setMovieDetails(decodedData)
                }catch let error{
                    
                }
                
            }
        }
        
        movieTask.resume()
    }
    
    
    func fetchTVShowDetails(tvShowID: Int){
        guard let tvUrl = URL(string: EndpointCase.tvShowDetails(environment: baseTvURL, tvShowID: "\(tvShowID)").url) else{return}
        let tvTask = DetailsInteractor.sharedURLSession.dataTask(with: tvUrl) { [weak self] (data, response, error) in
            guard let data = data else{
                return
            }
            if let error = error {
                print("Error fetching TV data: \(error.localizedDescription)")
            } else {
                
                do{
                    guard let decodedData = try self?.jsonDecoder.decode(Show.self, from: data) else {
                        return
                    }
                    self?.presenter?.setTvShowDetails(decodedData)
                    
                }catch let error {
                    
                }
            }
        }
        
        tvTask.resume()
    }
    
    
}
