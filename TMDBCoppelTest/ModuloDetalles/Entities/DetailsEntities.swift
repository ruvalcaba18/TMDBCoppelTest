//  DetailsEntities.swift
//  TMDBCoppelTest
//  Created by Jael  on 28/02/23.


import Foundation

struct DetailsMovie: Codable {
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int?
    let name: String?
    let logoPath: String?
    let originCountry: String?
    let headquarters: String?
    let description: String?
    let homepage: String?
    let parentCompany: String?
    
    enum CodingKeys: String, CodingKey {
            case id, name
            case logoPath = "logo_path"
            case originCountry = "origin_country"
            case headquarters, description, homepage
            case parentCompany = "parent_company"
    }
}

struct ProductionCountry: Codable {
    let iso31661: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let iso6391: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
    }
}

// MARK: TVShows

struct Show: Codable {
    let backdropPath: String?
    let createdBy: [Creator]
    let episodeRunTime: [Int]
    let firstAirDate: String
    let genres: [GenreTVShow]
    let homepage: String?
    let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String?
    let lastEpisodeToAir: Episode?
    let name: String
    let nextEpisodeToAir: Episode?
    let networks: [Network]
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionTVShowCompany]
    let productionCountries: [ProductionCountry]
    let seasons: [Season]
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres
        case homepage
        case id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
    }
}

struct Creator: Codable {
    let id: Int
    let creditId: String
    let name: String
    let gender: Int?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case creditId = "credit_id"
        case name
        case gender
        case profilePath = "profile_path"
    }
}

struct GenreTVShow: Codable {
    let id: Int
    let name: String
}

struct Episode: Codable {
    let airDate: String?
    let episodeNumber: Int
    let id: Int
    let name: String
    let overview: String?
    let productionCode: String?
    let seasonNumber: Int
    let stillPath: String?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id
        case name
        case overview
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Network: Codable {
    let name: String
    let id: Int
    let logoPath: String?
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

struct ProductionTVShowCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
struct Season: Codable {
    let airDate: String?
    let episodeCount: Int?
    let id: Int
    let name: String
    let overview: String?
    let posterPath: String?
    let seasonNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK:  ProductionCompanyLogo
struct ProductionCompanyLogo: Codable {
    let id: Int?
    let logos: [Logo]?
}

struct Logo: Codable {
    let aspectRatio: Double?
    let filePath: String?
    let height: Int?
    let id: Int?
    let fileType: String?
    let voteAverage: Double?
    let voteCount: Int?
    let width: Int?
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height, id
        case fileType = "file_type"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
