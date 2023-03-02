//
//  TMDBRouter.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
import UIKit
public class MovieRouter: MoviePresenterToRouter
{
   
    var view: UIViewController?
    public static func createMovieModule() -> UIViewController{
        
        let view =  UIStoryboard(name: "TMDBViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "TMDBViewController") as? TMDBViewController
        let presenter = MoviePresenter()
        let interactor = TMDBInteractor()
        let router = MovieRouter()
        router.view = view

        view?.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.baseURL = TMDBSDK.shared.environment.getBaseURL()
    
        return view ?? UIViewController()
    }
    

    func  moveToMovieDetail(movieId: Int, isShowingMoviesDetails: Bool) {
        let MovieDetails = DetailsRouter.createDetailsModule(movieId, isShowingMovieDetails: isShowingMoviesDetails)
        view?.navigationController?.pushViewController(MovieDetails, animated: true)
    }
    
    func moveToProfile() -> ProfileViewController {
        let profileView = ProfileRouter.createProfileModule()
        profileView.modalPresentationStyle = .pageSheet
        view?.navigationController?.pushViewController(profileView, animated: true)
        return profileView as! ProfileViewController
    }
    
    func moveToLogin() {
        view?.navigationController?.popViewController(animated: true)
    }
}
