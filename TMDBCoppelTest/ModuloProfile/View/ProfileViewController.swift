//  ProfileViewController.swift
//  TMDBCoppelTest
//  Created by Jael  on 28/02/23.

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: ProfileViewToPresenter?
    let movieInformation = MovieInformation()
    var allMovies: [MovieInformation]  = []
    var isShimmerActive = true
    
    let profileContainerView: UIView = {
        let profileView = UIView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.accessibilityIdentifier = "profileView"
        return profileView
    }()
    let favoriteContainer: UIStackView = {
        let favoriteStack = UIStackView()
        favoriteStack.axis = .vertical
        favoriteStack.distribution = .fill
        favoriteStack.alignment = .fill
        favoriteStack.translatesAutoresizingMaskIntoConstraints = false
        favoriteStack.accessibilityIdentifier = "favoriteStack"
        return favoriteStack
    }()
    
    let profileContainer: UIStackView = {
        let profileStack = UIStackView()
        profileStack.axis = .vertical
        profileStack.distribution = .fillEqually
        profileStack.alignment = .fill
        profileStack.translatesAutoresizingMaskIntoConstraints = false
        profileStack.accessibilityIdentifier = "profileStack"
        return profileStack
    }()
    
    let principalContainer: UIStackView = {
        let principalStack = UIStackView()
        principalStack.axis = .vertical
        principalStack.distribution = .fillEqually
        principalStack.alignment = .fill
        principalStack.translatesAutoresizingMaskIntoConstraints = false
        principalStack.accessibilityIdentifier = "principalStack"
        return principalStack
    }()
    
    let principalContainerView: UIView = {
        let principalView = UIView()
        principalView.translatesAutoresizingMaskIntoConstraints = false
        principalView.accessibilityIdentifier = "principalContainerView"
        return principalView
    }()
    
    let mainStackView: UIStackView = {
        let parentStack = UIStackView()
        parentStack.axis = .vertical
        parentStack.distribution = .fillEqually
        parentStack.alignment = .fill
        parentStack.translatesAutoresizingMaskIntoConstraints = false
        parentStack.accessibilityIdentifier = "mainStackView"
        return parentStack
    }()
  
    let profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(named: "profileImage")
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    
    let profileTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Profile"
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "nameLabel"
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@coppel.com"
        label.textColor = .systemGreen
        label.accessibilityIdentifier = "emailLabel"
        return label
    }()
    
    let favoriteMoviesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Favorite Shows"
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "favoriteMoviesLabel"
        return label
    }()
    
    let movieCarousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.allowsSelectionDuringEditing = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.accessibilityIdentifier = "movieCarousel"
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else{return}
        allMovies =  movieInformation.getAllMovies(in: context) ?? []
        view.backgroundColor = .black
        setUpUserInterface()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let alongsideHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = {[weak self] (context)    in
            self?.movieCarousel.reloadData()
        }
        
        let completionHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = {[weak self] (context)    in
            self?.movieCarousel.reloadData()
        }
        
        coordinator.animate(alongsideTransition: alongsideHandler, completion: completionHandler)
    }
    
    // MARK: - Private methods
    
    private func setUpUserInterface() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(principalContainerView)
        principalContainerView.addSubview(principalContainer)
        principalContainer.addArrangedSubview(profileContainer)
        principalContainer.addArrangedSubview(favoriteContainer)
        profileContainer.addArrangedSubview(profileContainerView)
        favoriteContainer.addArrangedSubview(favoriteMoviesLabel)
        favoriteContainer.addArrangedSubview(movieCarousel)
        
        profileContainerView.addSubview(profileImageView)
        profileContainerView.addSubview(emailLabel)
        profileContainerView.addSubview(profileTitle)
        
        profileContainerView.backgroundColor = .black
        movieCarousel.backgroundColor = .black
        principalContainerView.backgroundColor = .black
        
        
        configureConstraints()
        
        movieCarousel.delegate = self
        movieCarousel.dataSource = self
        movieCarousel.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.isShimmerActive = false
            self?.movieCarousel.reloadData()
        }
    }
    
    private func configureConstraints() {
        
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        principalContainer.topAnchor.constraint(equalTo: principalContainerView.topAnchor).isActive = true
        principalContainer.bottomAnchor.constraint(equalTo: principalContainerView.bottomAnchor).isActive = true
        principalContainer.leadingAnchor.constraint(equalTo: principalContainerView.leadingAnchor).isActive = true
        principalContainer.trailingAnchor.constraint(equalTo: principalContainerView.trailingAnchor).isActive = true
  
        profileTitle.topAnchor.constraint(equalTo: profileContainerView.topAnchor,constant: 20).isActive = true
        profileTitle.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor,constant: 30).isActive = true
        profileTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        profileImageView.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor,constant: 35).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: profileContainerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        emailLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,constant: 15).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: profileContainerView.centerYAnchor).isActive = true

        
        favoriteMoviesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isShimmerActive ? 5 : allMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        cell.shadowDecorate()
        if isShimmerActive{
            cell.addShimmerEffect()
            cell.posterPathImage.image = nil
            cell.titleLabel.text = ""
            cell.dateLabel.text = ""
            cell.starsLabel.text = ""
            cell.shortDescriptionMovieLabel.text = ""
            cell.containerView.backgroundColor = .black
        }else{
            cell.removeShimmerEffect()
            cell.containerView.backgroundColor = .greenOpaqueBackground()
            cell.posterPathImage.cacheImage(urlString: "https://image.tmdb.org/t/p/w200\(allMovies[indexPath.row].poster ?? "")")
            cell.titleLabel.text = allMovies[indexPath.row].title
            cell.dateLabel.text = allMovies[indexPath.row].releaseDate?.convertFormatteDate(fromFormat: "yyyy-MM-dd", toFormat: "MMM dd, yyyy")
            cell.shortDescriptionMovieLabel.text = allMovies[indexPath.row].mediaDescription ?? ""
            cell.starsLabel.text = " ⭐️ \(allMovies[indexPath.row].popularity )"
        }
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

