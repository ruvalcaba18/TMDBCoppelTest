//
//  TMDBErrors.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
enum MovieErrors:Error,CustomNSError{
    case apiError
    case invalidEndpoint
    case invalidRequest
    case invalidResponse
    case invalidDecoding
    case internetError
    
    var localizedDescription:String{
        switch self{
        
        case .apiError:
            return "Error to localize the movie"
        case .invalidEndpoint:
            return "Invalid endpoint, please verify which endpoint you sent."
        case .invalidRequest:
            return "invalidity variables to make the request"
        case .invalidResponse:
            return "Invalid response, check if your variables are ok "
        case .invalidDecoding:
            return "error when decoding the information"
        case .internetError:
        return "there was a failure with the internet"
        }
    }
}
