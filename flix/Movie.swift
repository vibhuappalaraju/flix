//
//  Movie.swift
//  
//
//  Created by Vibhu Appalaraju on 10/5/18.
//

import Foundation
class Movie {
    var title: String
    //var posterUrl: URL?
    var overview: String
    var releaseDate: String
    var backdropPath: String
    var posterPath: String
    var baseURLString: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? ""
        posterPath = dictionary["poster_path"] as! String
        releaseDate =  dictionary["release_date"] as! String
        backdropPath = dictionary["backdrop_path"] as! String 
        baseURLString = "https://image.tmdb.org/t/p/w500/"
        //posterUrl = URL(string: baseURLString + posterPath)
    
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
