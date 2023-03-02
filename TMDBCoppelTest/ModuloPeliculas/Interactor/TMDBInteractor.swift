//  TMDBInteractor.swift
//  TMDBCoppelTest
//  Created by Jael  on 27/02/23.

import Foundation

class TMDBInteractor:MoviePresenterToInteractor {
 
    // MARK: - Properties
    var presenter: MovieInteractorToPresenter?
    static var sharedURLSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = 50
        configuration.timeoutIntervalForResource = 50
        configuration.networkServiceType = .background
        return URLSession(configuration: configuration)
    }()
    private var dataTasks = [URLSessionDataTask]()
    
    var currentDataTask:URLSessionDataTask?
    var baseURL = ""
    let jsonDecoder = JSONDecoder()
    
    // MARK: - Private methods
    private func cancelCurrentRequest() {
        dataTasks.forEach { $0.cancel() }
    }
    
    // MARK: - Public methods
    func fetchPopularMovieList(page: String){
        cancelCurrentRequest()
        guard let url = URL(string: EndpointCase.popularMovies(environment: baseURL, page: page).url) else { return }
        
        currentDataTask = TMDBInteractor.sharedURLSession.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            
            do {
                if let decodedData = try self?.jsonDecoder.decode(CallMoviesResponse<MovieResponse>.self, from: data) {
                    self?.presenter?.setPopularMovies(movies: decodedData.results)
                } else {
                 
                }
            } catch let error {
                self?.presenter?.setInternetError(error: error.localizedDescription)
            }
        }
        
        currentDataTask?.resume()
        dataTasks.append(currentDataTask!)
    }
    
    func fetchOnTV(page: String) {
        
        cancelCurrentRequest()
        guard let url = URL(string: EndpointCase.onTV(environment: MoviesSDKEnvironment.onTV.getBaseURL(), page: page).url) else{ return }
        
        currentDataTask = TMDBInteractor.sharedURLSession.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            
            do {
                if let decodedData = try self?.jsonDecoder.decode(CallMoviesResponse<TVShow>.self, from: data) {
                    self?.presenter?.setOnTv(tvShows: decodedData.results)
                } else {
                    
                }
            } catch let error {
                self?.presenter?.setInternetError(error: error.localizedDescription)
            }
        }
        
        currentDataTask?.resume()
        dataTasks.append(currentDataTask!)
    }
    
    func fetchAiringToday(page: String) {
        cancelCurrentRequest()
        guard let url = URL(string: EndpointCase.airingToday(environment: MoviesSDKEnvironment.onTV.getBaseURL(), page: page).url) else{ return }
        
        currentDataTask = TMDBInteractor.sharedURLSession.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            
            do {
                if let decodedData = try self?.jsonDecoder.decode(CallMoviesResponse<TVShow>.self, from: data) {
                    self?.presenter?.setAiringToday(tvShows: decodedData.results)
                } else {
                    print("enter in else ")
                }
            } catch let error {
                self?.presenter?.setInternetError(error: error.localizedDescription)
            }
        }
        
        currentDataTask?.resume()
        dataTasks.append(currentDataTask!)
    }
    
    func fetchTopRated(page:String){
        cancelCurrentRequest()
        guard let url = URL(string: EndpointCase.topRated(environment: baseURL, page: page).url) else { return }
        
        currentDataTask = TMDBInteractor.sharedURLSession.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            
            do {
                if let decodedData = try self?.jsonDecoder.decode(CallMoviesResponse<MovieResponse>.self, from: data) {
                    self?.presenter?.setTopRated(movies: decodedData.results)
                } else {
             
                }
            } catch let error {
                self?.presenter?.setInternetError(error: error.localizedDescription)
            }
        }
        
        currentDataTask?.resume()
        dataTasks.append(currentDataTask!)
    }
    
    func fetchPopularMovieListTest(page: String, completion: @escaping ([MovieResponse]) -> Void) {
        cancelCurrentRequest()
        guard let url = URL(string: EndpointCase.popularMovies(environment: baseURL, page: page).url) else { return }
        
        currentDataTask = TMDBInteractor.sharedURLSession.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            
            do {
                if let decodedData = try self?.jsonDecoder.decode(CallMoviesResponse<MovieResponse>.self, from: data) {
                    completion(decodedData.results)
                } else {
                }
            } catch let error {
                self?.presenter?.setInternetError(error: error.localizedDescription)
            }
        }
        
        currentDataTask?.resume()
        dataTasks.append(currentDataTask!)
    }
    
}
