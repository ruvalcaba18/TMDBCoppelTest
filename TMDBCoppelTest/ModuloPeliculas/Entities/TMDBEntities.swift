//
//  TMDBEntities.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation

struct CallMoviesResponse<T: Codable>: Codable {
    let results: [T]
}
struct MovieResponse:Codable{
    
    var adult:Bool?
    var backdroppath:String?
    var id:Int?
    var genreids:[Int]?
    var originallanguage:OriginalLanguage?
    var releasedate:String?
    var originaltitle:String?
    var overview:String?
    var popularity:Double?
    var posterpath:String?
    var title:String?
    var video:Bool?
    var voteaverage:Double?
    var votecount:Int?
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdroppath = "backdrop_path"
        case id = "id"
        case genreids = "genre_ids"
        case originallanguage = "original_language"
        case originaltitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterpath = "poster_path"
        case releasedate = "release_date"
        case title = "title"
        case video = "video"
        case voteaverage = "vote_average"
        case votecount = "vote_count"
      }
    
}



struct TVShow: Codable {
    let posterPath: String?
    let popularity: Double
    let id: Int
    let backdropPath: String?
    let voteAverage: Double
    let overview: String
    let firstAirDate: String
    let originCountry: [String]
    let genreIds: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name: String
    let originalName: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity
        case id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}


enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case zh = "zh"
    case ru = "ru"
    case ja = "ja"
    case sv = "sv"
    case ko = "ko"
    case fr = "fr"
    case hi = "hi"
    case pl = "pl"
    case it = "it"
    case pt = "pt"
    case cn = "cn"
    case da = "da"
    case de = "de"
    case no = "no"
    case ms = "ms"
}
