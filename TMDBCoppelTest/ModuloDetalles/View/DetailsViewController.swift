//
//  DetailsViewController.swift
//  TMDBCoppelTest
//  Created by Jael  on 28/02/23.

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    // MARK: - Variables
    var mediaID = 0
    var presenter:DetailsViewToPresenter?
    var isShowingMoviesDetails = true
    var isShimmerActive = true
    var context: NSManagedObjectContext?
    var companyProduction = [ProductionCompany]()
    var currentArray: [Any] = []
    var tvCompanyProduction = [ProductionTVShowCompany]()
    let movieInformation = MovieInformation()
    
    var favoriteMediaDescription = ""
    var favoriteMediaPopularity = 0.0
    var favoriteMediaPoster = ""
    var favoriteMediaReleaseDate = ""
    var favoriteMediaTitle = ""
    var imdbID = ""
    
    
    //MARK: - Outlets
    @IBOutlet var companieLogoLabel: UILabel!
    @IBOutlet var IMDBButton: UIButton!{
        didSet{
            IMDBButton.layer.cornerRadius = 15
            IMDBButton.clipsToBounds = true
        }
    }
    @IBOutlet var scrollViewContainer: UIScrollView!
    @IBOutlet var raitingLabel: UILabel!
    @IBOutlet var titleView: UIView!
    @IBOutlet var IMDBView: UIView!
    @IBOutlet var favoriteView: UIView!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var posterPathImageView: UIImageView!
    @IBOutlet var AddToFavorites: UIButton!{
        didSet{
            AddToFavorites.layer.cornerRadius = 15
            AddToFavorites.clipsToBounds = true
        }
    }
    @IBOutlet var viewDescription: UIView!
    @IBOutlet var titleMovie: UILabel!
    @IBOutlet var companiesImageColletion: UICollectionView!{
        didSet{
            companiesImageColletion.dataSource = self
            companiesImageColletion.delegate = self
            companiesImageColletion.register(CompanieCollectionViewCell.self, forCellWithReuseIdentifier: CompanieCollectionViewCell.identifier)
        }
    }
    
    
    //MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.getMovieOrTVShowDetail(mediaID: mediaID, isMovieDetails: isShowingMoviesDetails)
        posterPathImageView.image = nil
        titleMovie.text = ""
        labelDescription.text = ""
        raitingLabel.text = ""
        IMDBButton.backgroundColor = .black
        IMDBButton.setTitleColor(.black, for: .normal)
        AddToFavorites.backgroundColor = .black
        AddToFavorites.setTitleColor(.black, for: .normal)
        companieLogoLabel.text = ""
        companieLogoLabel.addShimmerEffect()
        IMDBView.addShimmerEffect()
        favoriteView.addShimmerEffect()
        labelDescription.addShimmerEffect()
        AddToFavorites.addShimmerEffect()
        IMDBButton.addShimmerEffect()
        titleMovie.addShimmerEffect()
        posterPathImageView.addShimmerEffect()
        raitingLabel.addShimmerEffect()
        scrollViewContainer.addShimmerEffect()
    }
    
    
    //MARK: - Internal Methods
    @IBAction func addToFavoritesAction(_ sender: UIButton) {
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else{return}
        
        movieInformation.createMovie(in: context, title: favoriteMediaTitle, releaseDate: favoriteMediaReleaseDate, popularity: favoriteMediaPopularity, mediaDescription:favoriteMediaDescription, poster: favoriteMediaPoster)
        
    }
    
    @IBAction func goToIMDB(_ sender: UIButton) {
        let imdbVC = IMDBViewController()
        imdbVC.modalPresentationStyle = .overCurrentContext
        imdbVC.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        imdbVC.preferredContentSize = CGSize(width: 400, height: 600)
        imdbVC.loadIMDBPage(for: imdbID)
        present(imdbVC, animated: true)
        
        
    }
    
}

// MARK: UICollectionViewDelegate
extension DetailsViewController: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

// MARK: UICollectionViewDataSource
extension DetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isShimmerActive ? 10 : currentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanieCollectionViewCell.identifier, for: indexPath) as? CompanieCollectionViewCell else {return UICollectionViewCell()}
        
        cell.shadowDecorate()
        
        
        if isShimmerActive
        {
            cell.isUserInteractionEnabled = false
            cell.addShimmerEffect()
            cell.logoPath.addShimmerEffect()
            cell.homePageLabel.addShimmerEffect()
            cell.nameLabel.addShimmerEffect()
            cell.placeLabel.addShimmerEffect()
            
            cell.logoPath.image = nil
            cell.homePageLabel.text = ""
            cell.nameLabel.text = ""
            cell.placeLabel.text = ""
        }
        else
        {
            cell.isUserInteractionEnabled = true
            cell.removeShimmerEffect()
            cell.logoPath.removeShimmerEffect()
            cell.homePageLabel.removeShimmerEffect()
            cell.nameLabel.removeShimmerEffect()
            cell.placeLabel.removeShimmerEffect()
            
            guard let item = currentArray[safe: indexPath.row] else { return cell }
            
            switch item {
            case let movie as ProductionCompany:
                configureCellForMovie(cell, movie: movie)
            case let tvShow as ProductionTVShowCompany:
                configureCellForTVShow(cell, tvShow: tvShow)
            default:
                break
            }
        }
        
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        
        
        return cell
    }
    
    private func configureCellForMovie(_ cell: CompanieCollectionViewCell, movie: ProductionCompany){
        cell.logoPath.cacheImage(urlString: "https://image.tmdb.org/t/p/w200\(movie.logoPath ?? "")")
        cell.nameLabel.text = "Name: \(movie.name ?? "NC")"
        cell.placeLabel.text = "Place: \(movie.headquarters ?? "NC")"
        cell.homePageLabel.text = "Home Page: \(movie.homepage ?? "")"
    }
    
    private func configureCellForTVShow(_ cell: CompanieCollectionViewCell, tvShow: ProductionTVShowCompany) {
        cell.logoPath.cacheImage(urlString: "https://image.tmdb.org/t/p/w200\(tvShow.logoPath ?? "")")
        cell.nameLabel.text = "Name: \(tvShow.name ?? "NC")"
        cell.placeLabel.text = "Place: \(tvShow.originCountry ?? "NC")"
        cell.homePageLabel.text = "Home Page: "
    }
    
    private func updateUI(withArray array: [Any]) {
        currentArray = isShowingMoviesDetails ? companyProduction : tvCompanyProduction
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {[weak self] in
            self?.isShimmerActive = false
            self?.companiesImageColletion.reloadData()
        }
    }
    
    
}

// MARK: PresenterToVieW
extension DetailsViewController : DetailsPresenterToView {
    
    
  
    
    func setTvShowDetails(_ tvShowDetails: Show) {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.title = "TV Show Detail"
            self?.companieLogoLabel.removeShimmerEffect()
            self?.IMDBButton.backgroundColor = .systemYellow
            self?.IMDBButton.setTitleColor(.black, for: .normal)
            self?.AddToFavorites.backgroundColor = .systemPink
            self?.AddToFavorites.setTitleColor(.white, for: .normal)
            self?.labelDescription.textColor = .white
            self?.IMDBView.removeShimmerEffect()
            self?.favoriteView.removeShimmerEffect()
            self?.labelDescription.removeShimmerEffect()
            self?.AddToFavorites.removeShimmerEffect()
            self?.IMDBButton.removeShimmerEffect()
            self?.titleMovie.removeShimmerEffect()
            self?.posterPathImageView.removeShimmerEffect()
            self?.raitingLabel.removeShimmerEffect()
            self?.companieLogoLabel.text = "Companies Logo"
            
            self?.scrollViewContainer.removeShimmerEffect()
            self?.posterPathImageView.cacheImage(urlString: "https://image.tmdb.org/t/p/w200\(tvShowDetails.posterPath ?? "")")
            self?.titleMovie.text = "TvShow Title: \(tvShowDetails.originalName)"
            self?.labelDescription.text = "Description: \(tvShowDetails.overview ?? "" )"
            let formatter = String(format: "%.1f", tvShowDetails.popularity)
            self?.raitingLabel.text = "⭐️ \(formatter)"
            self?.IMDBButton.isHidden = true
            self?.tvCompanyProduction.append(contentsOf: tvShowDetails.productionCompanies)
            self?.updateUI(withArray: self!.tvCompanyProduction)
            self?.isShimmerActive = false
            
        }
        
        favoriteMediaDescription = tvShowDetails.overview ?? ""
        favoriteMediaPopularity = tvShowDetails.popularity
        favoriteMediaPoster = "https://image.tmdb.org/t/p/w200\(tvShowDetails.posterPath ?? "")"
        favoriteMediaReleaseDate = tvShowDetails.firstAirDate
        favoriteMediaTitle = tvShowDetails.originalName
        
    }
    
    
    func setMovieDetails(_ movieDetails: DetailsMovie) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.title = "Movie Detail"
            self?.IMDBButton.backgroundColor = .systemYellow
            self?.IMDBButton.setTitleColor(.black, for: .normal)
            self?.AddToFavorites.backgroundColor = .systemPink
            self?.AddToFavorites.setTitleColor(.white, for: .normal)
            self?.labelDescription.textColor = .white
            self?.IMDBView.removeShimmerEffect()
            self?.favoriteView.removeShimmerEffect()
            self?.labelDescription.removeShimmerEffect()
            self?.AddToFavorites.removeShimmerEffect()
            self?.IMDBButton.removeShimmerEffect()
            self?.titleMovie.removeShimmerEffect()
            self?.posterPathImageView.removeShimmerEffect()
            self?.raitingLabel.removeShimmerEffect()
            self?.scrollViewContainer.removeShimmerEffect()
            self?.companieLogoLabel.text = "Companies Logo"
            self?.companieLogoLabel.removeShimmerEffect()
            self?.companiesImageColletion.reloadData()
            self?.posterPathImageView.cacheImage(urlString: "https://image.tmdb.org/t/p/w200\(movieDetails.posterPath ?? "")")
            self?.titleMovie.text = "Movie Title: \(movieDetails.originalTitle)"
            self?.labelDescription.text = "Description: \n \(movieDetails.overview)"
            let formatter = String(format: "%.1f", movieDetails.voteAverage)
            self?.raitingLabel.text = "⭐️ \(formatter)"
            if movieDetails.imdbId == nil {
                self?.IMDBButton.isHidden = true
            }
            self?.companyProduction.append(contentsOf: movieDetails.productionCompanies)
            self?.updateUI(withArray: self!.companyProduction)
            self?.isShimmerActive = false
            self?.imdbID = movieDetails.imdbId ?? ""
        }
        
        favoriteMediaDescription = movieDetails.overview
        favoriteMediaPopularity = movieDetails.voteAverage
        favoriteMediaPoster = "https://image.tmdb.org/t/p/w200\(movieDetails.posterPath ?? "")"
        favoriteMediaReleaseDate = movieDetails.releaseDate
        favoriteMediaTitle = movieDetails.title
        
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height: CGFloat = (collectionView.bounds.height)*0.6
        let widthPerItem = (collectionView.bounds.width) / 2.2 * 1.5
        return CGSize(width: widthPerItem, height:height)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
    }
}
