//  TMDBViewController.swift
//  TMDBCoppelTest
//  Created by Jael  on 27/02/23.

import UIKit

class TMDBViewController: UIViewController {
    
    // MARK: - Variables
    var presenter: MovieViewToPresenter?
    var pages = 1
    var isShimmerActive = true
    var isShowingMovies = true
    var moviesResponse: [MovieResponse] = []
    var tvShowsResponse:[TVShow] = []
    var currentArray: [Any] = []
    let alertController = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
    
    
    //MARK: - Outlets
    @IBOutlet var mainCollectionView: UICollectionView!{
        didSet
        {
            mainCollectionView.delegate = self
            mainCollectionView.dataSource = self
            mainCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
            mainCollectionView.accessibilityIdentifier = "mainCollectionView"
            mainCollectionView.backgroundColor = .black
        }
    }
    @IBOutlet var mainContainerView: UIView!{
        didSet
        {
            mainContainerView.accessibilityIdentifier = "mainContainerView"
            mainContainerView.backgroundColor = .darkGray
        }
    }
    
    @IBOutlet var typeOfMovieController: UISegmentedControl!{
        didSet
        {
            typeOfMovieController.setBackgroundImage(imageWithColor(color: UIColor.black), for: .normal, barMetrics: .default)
            typeOfMovieController.setBackgroundImage(imageWithColor(color: UIColor.lightGray), for: .selected, barMetrics: .default)
            let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            typeOfMovieController.setTitleTextAttributes(normalAttributes, for: .normal)
            typeOfMovieController.setTitleTextAttributes(selectedAttributes, for: .selected)
            
        }
    }
    
    //MARK: - ViewController life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupNavigationBar()
        presenter?.getPopularMovies(pages: "\(pages)")
        view.backgroundColor = .darkGray
        navigationItem.title = "TV Shows"
        navigationController?.navigationBar.backgroundColor = .darkGray
        navigationItem.hidesBackButton = true
        setupAlertController()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let alongsideHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = {[weak self] (context)    in
            self?.mainCollectionView.reloadData()
        }
        
        let completionHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = {[weak self] (context)    in
            self?.mainCollectionView.reloadData()
        }
        
        coordinator.animate(alongsideTransition: alongsideHandler, completion: completionHandler)
    }
    
    @IBAction func typeOfMovie(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex {
        case 0:
            isShowingMovies = true
            isShimmerActive = true
            currentArray = []
            DispatchQueue.main.async { [weak self] in
                self?.mainCollectionView.reloadData()
            }
            self.presenter?.getPopularMovies(pages: "\(pages)")
        case 1:
            isShowingMovies = true
            isShimmerActive = true
            currentArray = []
            DispatchQueue.main.async { [weak self] in
                self?.mainCollectionView.reloadData()
            }
            self.presenter?.getTopRate(page: "\(pages)")
        case 2:
            isShowingMovies = false
            isShimmerActive = true
            currentArray = []
            DispatchQueue.main.async { [weak self] in
                self?.mainCollectionView.reloadData()
            }
            self.presenter?.getOnTv(page: "\(pages)")
        case 3:
            isShowingMovies = false
            isShimmerActive = true
            currentArray = []
            DispatchQueue.main.async { [weak self] in
                self?.mainCollectionView.reloadData()
            }
            self.presenter?.getAiringToday(page: "\(pages)")
        default:
            isShowingMovies = true
            isShimmerActive = true
            currentArray = []
            DispatchQueue.main.async { [weak self] in
                self?.mainCollectionView.reloadData()
            }
            self.presenter?.getPopularMovies(pages: "\(pages)")
        }
        
    }
    
    //MARK: - Internal Methods
    private func imageWithColor(color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    @objc func menuButtonTapped(sender: UIBarButtonItem) {
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "menucard"), style: .plain, target: self, action: #selector(menuButtonTapped(sender:)))
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = menuButton
    }
    
    
    private func setupAlertController() {
        
        alertController.view.accessibilityIdentifier = "custom_alert"
        
        let viewProfileAction = UIAlertAction(title: "View Profile", style: .default) { [weak self] _ in
            self?.presenter?.router?.moveToProfile()
        }
        
        let logOutAction = UIAlertAction(title: "Log out", style: .default) { [weak self] _ in
            self?.presenter?.router?.moveToLogin()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {[weak self] _ in
            
        }
        
        logOutAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        alertController.addAction(viewProfileAction)
        alertController.addAction(logOutAction)
        alertController.addAction(cancel)
    }
    
}


extension TMDBViewController: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell else {return }
        
        self.presenter?.router?.moveToMovieDetail(movieId: cell.movieID, isShowingMoviesDetails: isShowingMovies)
    }
}

extension TMDBViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  isShimmerActive ? 10 : currentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}
        
        cell.shadowDecorate()
        
        if isShimmerActive
        {
            cell.isUserInteractionEnabled = false
            cell.addShimmerEffect()
            cell.posterPathImage.image = nil
            cell.titleLabel.text = ""
            cell.dateLabel.text = ""
            cell.starsLabel.text = ""
            cell.shortDescriptionMovieLabel.text = ""
            cell.containerView.backgroundColor = .black
        }
        else
        {
            cell.isUserInteractionEnabled = true
            cell.removeShimmerEffect()
            cell.containerView.backgroundColor = .greenOpaqueBackground()
            
            guard let item = currentArray[safe: indexPath.row] else { return cell }
            
            switch item {
            case let movie as MovieResponse:
                configureCellForMovie(cell, movie: movie)
            case let tvShow as TVShow:
                configureCellForTVShow(cell, tvShow: tvShow)
            default:
                break
            }
        }
        
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        
        return cell
        
    }
    
    private func configureCellForMovie(_ cell: MovieCollectionViewCell, movie: MovieResponse){
        cell.posterPathImage.cacheImage(urlString: "https://image.tmdb.org/t/p/w200\(movie.posterpath ?? "")")
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = movie.releasedate?.convertFormatteDate(fromFormat: "yyyy-MM-dd", toFormat: "MMM dd, yyyy")
        cell.shortDescriptionMovieLabel.text = movie.overview
        cell.starsLabel.text = " ⭐️ \(movie.voteaverage ?? 0.0 )"
        cell.movieID = movie.id ?? 0
    }
    
    private func configureCellForTVShow(_ cell: MovieCollectionViewCell, tvShow: TVShow) {
        cell.posterPathImage.cacheImage(urlString: "https://image.tmdb.org/t/p/w200\(tvShow.posterPath ?? "")")
        cell.titleLabel.text = tvShow.originalName
        cell.dateLabel.text = tvShow.firstAirDate.convertFormatteDate(fromFormat: "yyyy-MM-dd", toFormat: "MMM dd, yyyy")
        cell.shortDescriptionMovieLabel.text = tvShow.overview
        cell.starsLabel.text = " ⭐️ \(tvShow.voteAverage )"
        cell.movieID = tvShow.id 
    }
    
}
extension TMDBViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if isShimmerActive {
            let height: CGFloat = (collectionView.bounds.height)*0.25
            let widthPerItem = (collectionView.bounds.width/2) * 0.9
            return CGSize(width: widthPerItem, height:height)
        } else {
            let height: CGFloat = (collectionView.bounds.height)*0.5
            let widthPerItem = (collectionView.bounds.width) / 2.2
            return CGSize(width: widthPerItem, height:height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
    }
}

//  MARK: - MoviePresenterToView
extension TMDBViewController: MoviePresenterToView {
    
    private func updateUI(withArray array: [Any]) {
        currentArray = isShowingMovies ? moviesResponse : tvShowsResponse
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {[weak self] in
            self?.isShimmerActive = false
            self?.mainCollectionView.reloadData()
        }
    }
    
    func setPopularMovies(movies: [MovieResponse]) {
        moviesResponse.append(contentsOf: movies)
        updateUI(withArray: moviesResponse)
    }
    
    func setTopRated(movies: [MovieResponse]) {
        moviesResponse.append(contentsOf: movies)
        updateUI(withArray: moviesResponse)
    }
    
    func setOnTv(tvShows: [TVShow]) {
        tvShowsResponse.append(contentsOf: tvShows)
        updateUI(withArray: tvShowsResponse)
    }
    
    func setAiringToday(tvShows: [TVShow]) {
        tvShowsResponse.append(contentsOf: tvShows)
        updateUI(withArray: tvShowsResponse)
    }
    func onResponseError(error: String) {
        
    }
    
}
