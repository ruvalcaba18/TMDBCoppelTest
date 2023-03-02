//
//  MovieInformation+CoreDataClass.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 01/03/23.
//
//

import Foundation
import CoreData

@objc(MovieInformation)
public class MovieInformation: NSManagedObject {

    // Create operation
    func createMovie(in context: NSManagedObjectContext, title: String, releaseDate: String, popularity: Double, mediaDescription: String?, poster: String?) -> MovieInformation? {
        let movie = MovieInformation(context: context)
        movie.title = title
        movie.releaseDate = releaseDate
        movie.popularity = popularity
        movie.mediaDescription = mediaDescription
        movie.poster = poster
        do {
            try context.save()
            return movie
        } catch {
            return nil
        }
    }

    // Read operation
    func getAllMovies(in context: NSManagedObjectContext) -> [MovieInformation]? {
        let fetchRequest: NSFetchRequest<MovieInformation> = MovieInformation.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }

    // Update operation
    func updateMovie(title: String, releaseDate: String, popularity: Double, mediaDescription: String?, poster: String?) -> Bool {
        self.title = title
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.mediaDescription = mediaDescription
        self.poster = poster
        do {
            try managedObjectContext?.save()
            return true
        } catch {
            return false
        }
    }

    // Delete operation
    func deleteMovie() -> Bool {
        managedObjectContext?.delete(self)
        do {
            try managedObjectContext?.save()
            return true
        } catch {
            return false
        }
    }

}
