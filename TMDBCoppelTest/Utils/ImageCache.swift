//
//  ImageCache.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
 
    func cacheImage(urlString: String){
      
      let url = URL(string: urlString)

      image = UIImage(named: "noimage")
      
      if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
          self.image = imageFromCache
          return
      }
          
      URLSession.shared.dataTask(with: url!) {[weak self] data, response, error in
          if data != nil {
                DispatchQueue.main.async {[weak self] in
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache ?? UIImage(), forKey: urlString as AnyObject)
                    self?.image = imageToCache
                }
            }
       }.resume()
    }
    
}
