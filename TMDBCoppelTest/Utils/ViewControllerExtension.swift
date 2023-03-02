//
//  ViewControllerExtension.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
import UIKit
extension UIViewController{
    
    func startActivityIndicator(loader:UIActivityIndicatorView,ownerView:UIView){
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        view.addSubview(ownerView)
        view.bringSubviewToFront(ownerView)
        ownerView.topAnchor.constraint(equalTo:view.topAnchor , constant: 0).isActive = true
        ownerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        ownerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        ownerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        ownerView.backgroundColor = .clear
        ownerView.center = CGPoint(x: self.view.bounds.size.width/2 , y: self.view.bounds.size.height/2 - 50)
        
        loader.color = .systemGreen
        loader.style = .large
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        loader.transform = transform
        loader.startAnimating()
        self.view.addSubview(loader)
        self.view.bringSubviewToFront(loader)
        loader.center = CGPoint(x: self.view.bounds.size.width/2 , y: self.view.bounds.size.height/2 )
        
    }
    
    func stopActivityIndicator(loader:UIActivityIndicatorView,ownerView:UIView){
        
        view.alpha = 1
        
        DispatchQueue.main.async {
            loader.stopAnimating()
            loader.removeFromSuperview()
            ownerView.removeFromSuperview()
            
            for subview in self.view.subviews {
                if let blurView = subview as? UIVisualEffectView {
                    blurView.removeFromSuperview()
                }
            }
        }
    }
}
