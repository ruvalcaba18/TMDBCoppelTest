//
//  TMDBEnvironment.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation

//  let url = URL(string: "https://www.imdb.com/find?q=\(encodedName)&s=tt&ttype=tv")
public enum MoviesSDKEnvironment{
    case basic
    case onTV
    case companies
    case imdb
    
    func getBaseURL() -> String{
        switch self{
        case .basic:
            return "https://api.themoviedb.org/3/movie"
        case .onTV:
            return "https://api.themoviedb.org/3/tv"
        case .companies:
            return "https://api.themoviedb.org/3/company"
        case .imdb:
            return "https://www.imdb.com/find?q="
        }
    }
    
}

enum EndpointCase {

    case onTV(environment:String,page:String)
    case popularMovies(environment:String,page:String)
    case detailMovies(environment:String,movieId:String)
    case topRated(environment:String,page:String)
    case airingToday(environment:String,page:String)
    case tvShowDetails(environment:String,tvShowID:String)
    case companiesImages(environment:String,companieID:String)
    case imdbSearch(environment:String,encodedName:String)
    var url:String{
        switch self {
       
        case .onTV(environment: let environment, page: let page):
            return "\(environment)/on_the_air?api_key=b64d7f3ead34bfc2d9ade2eb40d81e37&language=en-US&page=\(page)"
        case .popularMovies(environment: let environment, page: let page):
            return "\(environment)/popular?api_key=b64d7f3ead34bfc2d9ade2eb40d81e37&language=en-US&page=\(page)"
        case .detailMovies(environment: let environment, movieId: let movieId):
            return "\(environment)/\(movieId)?api_key=b64d7f3ead34bfc2d9ade2eb40d81e37&language=en-US"
        case .topRated(environment: let environment, page: let page):
            return "\(environment)/top_rated?api_key=b64d7f3ead34bfc2d9ade2eb40d81e37&language=en-US&page=\(page)"
        case .airingToday(environment: let environment, page: let page):
            return "\(environment)/airing_today?api_key=b64d7f3ead34bfc2d9ade2eb40d81e37&language=en-US&page=\(page)"
        case .tvShowDetails(environment: let environment, tvShowID: let tvShowID):
            return "\(environment)/\(tvShowID)?api_key=b64d7f3ead34bfc2d9ade2eb40d81e37&language=en-US"
        case .companiesImages(environment: let environment, companieID: let companieID):
            return "\(environment)/\(companieID)?api_key=b64d7f3ead34bfc2d9ade2eb40d81e37"
        
        case .imdbSearch(environment: let environment, encodedName: let encodedName):
            return "\(environment)\\\(encodedName)&s=tt&ttype=tv"
        }
    }

}
