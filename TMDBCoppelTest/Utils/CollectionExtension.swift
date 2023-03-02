//
//  CollectionExtension.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 28/02/23.
//

import Foundation
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
