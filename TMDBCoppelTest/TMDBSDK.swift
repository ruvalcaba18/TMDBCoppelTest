//
//  TMDBSDK.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
import UIKit.UIViewController

public class TMDBSDK{
    
    public static let bundle = Bundle(for: TMDBSDK.self)
    public var environment: MoviesSDKEnvironment = .basic

    public static let shared = TMDBSDK()
    
    
    public static func openMovieModule(environment: MoviesSDKEnvironment,secondEnvironment: MoviesSDKEnvironment) -> UIViewController {
        var view:UIViewController?
        TMDBSDK.shared.environment = environment
        view = MovieRouter.createMovieModule()
           return view!
       }
    
}
