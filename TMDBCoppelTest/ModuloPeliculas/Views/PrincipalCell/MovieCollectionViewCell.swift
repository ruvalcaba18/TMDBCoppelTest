//
//  MovieCollectionViewCell.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet var posterPathImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    @IBOutlet var shortDescriptionMovieLabel: UILabel!
    public var movieID = 0 
    @IBOutlet var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 15
            containerView.clipsToBounds = true
        }
    }
    // MARK: - Properties
    static let identifier = "MovieCollectionViewCell"

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTopCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    // MARK: - Methods
    func setUpTopCell(){
        self.fromNib()
        self.accessibilityIdentifier = "movieCell"
        
    }

}
