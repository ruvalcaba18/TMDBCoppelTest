//
//  ViewExtension.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
import UIKit
let kWidth = UIScreen.main.bounds.width
let kHeight = UIScreen.main.bounds.height

public extension UIView {
    func addShimmerEffect() {
        
        layer.masksToBounds = true
        let shimmerView = UIView(frame: CGRect(x: 0, y: -50, width: kHeight*2, height: kHeight*2))
        shimmerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        shimmerView.clipsToBounds = true
        shimmerView.tag = 1001
        addSubview(shimmerView)
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor, UIColor.clear.cgColor]
        
        
        gradientLayer.locations = [0, 0.1]
        gradientLayer.startPoint = CGPoint(x: 0.7, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
        
        gradientLayer.frame = shimmerView.frame
        
        shimmerView.layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 1
        animation.fromValue = -(shimmerView.frame.width)
        animation.toValue = shimmerView.frame.width
        animation.repeatCount = Float.infinity

        animation.isRemovedOnCompletion = false
        
        gradientLayer.add(animation, forKey: "")
    }
    
    func removeShimmerEffect() {
        for subview in self.subviews where subview.tag == 1001 {
            subview.removeFromSuperview()
            subview.layer.mask = nil
        }
    }
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            debugPrint("No se cargo nib \(String(describing: self))")
            return nil
        }
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
        return contentView
    }
    
    var isDisplayed: Bool {
            return !isHidden && alpha != 0
        }
}
