//
//  CollecontionViewExtension.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
import UIKit

extension UICollectionViewCell{
func shadowDecorate() {
    
    let radius: CGFloat = 10
    contentView.layer.cornerRadius = radius
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.clear.cgColor
    contentView.layer.masksToBounds = true

    layer.shadowColor = UIColor.white.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 8.0)
    layer.shadowRadius = 4.0
    layer.shadowOpacity = 0.2
    layer.masksToBounds = false
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    layer.cornerRadius = radius
}
}
