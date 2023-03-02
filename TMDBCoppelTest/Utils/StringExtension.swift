//
//  StringExtension.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import Foundation
extension String {
    
    func convertFormatteDate(fromFormat: String, toFormat: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = fromFormat
            
            guard let date = dateFormatter.date(from: self) else {
                return ""
            }
            
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        }
}
