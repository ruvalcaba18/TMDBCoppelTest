//
//  CompanieCollectionViewCell.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 01/03/23.
//

import UIKit

class CompanieCollectionViewCell: UICollectionViewCell {

    @IBOutlet var principalContainerView: UIView!{
        didSet{
            principalContainerView.layer.cornerRadius = 15
            principalContainerView.clipsToBounds = true
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var logoPath: UIImageView!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var homePageLabel: UILabel!
    static let identifier = "CompanieCollectionViewCell"

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
        self.accessibilityIdentifier = "CompanieCell"
        
    }


}
