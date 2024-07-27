//
//  MovieDomain.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import Foundation
import UIKit


struct MovieDomain {
    let adult: Bool
        let backdropPath: String
        let genreIds: [Int]
        let id: Int
        let originalLanguage: String
        let originalTitle: String
        let overview: String
        let popularity: Double
        let posterPath: String?
        let releaseDate: String
        let title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int
        var image: UIImage?
        
        init(movie: Movie, image: UIImage? = nil) {
            self.adult = movie.adult
            self.backdropPath = movie.backdropPath
            self.genreIds = movie.genreIds
            self.id = movie.id
            self.originalLanguage = movie.originalLanguage
            self.originalTitle = movie.originalTitle
            self.overview = movie.overview
            self.popularity = movie.popularity
            self.posterPath = movie.posterPath
            self.releaseDate = movie.releaseDate
            self.title = movie.title
            self.video = movie.video
            self.voteAverage = movie.voteAverage
            self.voteCount = movie.voteCount
            self.image = image
        }

}
