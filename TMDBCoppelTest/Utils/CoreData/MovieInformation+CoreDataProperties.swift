//
//  MovieInformation+CoreDataProperties.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 01/03/23.
//
//

import Foundation
import CoreData


extension MovieInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieInformation> {
        return NSFetchRequest<MovieInformation>(entityName: "MovieInformation")
    }

    @NSManaged public var mediaDescription: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?

}

extension MovieInformation : Identifiable {

}
