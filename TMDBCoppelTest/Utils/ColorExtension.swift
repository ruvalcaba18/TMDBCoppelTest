//
//  ColorExtension.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
import UIKit

extension UIColor{

    convenience init(hex: String) {
          let scanner = Scanner(string: hex)
          scanner.scanLocation = 0
          
          var rgbValue: UInt64 = 0
          scanner.scanHexInt64(&rgbValue)
          
          let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
          let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
          let b = CGFloat(rgbValue & 0x0000FF) / 255.0
          
          self.init(red: r, green: g, blue: b, alpha: 1.0)
      }

    static func greenOpaqueBackground() -> UIColor{
        return UIColor(red: 0.00, green: 0.30, blue: 0.25, alpha: 1.00)
    }
   
}
