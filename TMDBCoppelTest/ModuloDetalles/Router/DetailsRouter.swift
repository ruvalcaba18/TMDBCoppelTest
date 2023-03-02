//  DetailsRouter.swift
//  TMDBCoppelTest
//  Created by Jael  on 28/02/23.

import Foundation
import UIKit
public class DetailsRouter: DetailsPresenterToRouter
{
   
    var view: UIViewController?
    
    public static func createDetailsModule(_ withID:Int,isShowingMovieDetails:Bool) -> UIViewController{
        let detailViewController = DetailsViewController(nibName: "DetailsViewController", bundle: Bundle.main)

        let view =  DetailsViewController()
        let presenter = DetailsPresenter()
        let interactor = DetailsInteractor()
        let router = DetailsRouter()
        router.view = view
        
        view.mediaID = withID
        view.isShowingMoviesDetails = isShowingMovieDetails

        view.presenter = presenter
        presenter.view = view 
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.baseTvURL = MoviesSDKEnvironment.onTV.getBaseURL()
        interactor.baseMovieURL = MoviesSDKEnvironment.basic.getBaseURL()
        interactor.baseIMDBUrl = MoviesSDKEnvironment.imdb.getBaseURL()
        return view
    }
    

}
