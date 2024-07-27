//
//  MovieCategory.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import Foundation


enum MovieCategory: Int, CaseIterable {
    case popular
    case topRated
    
    var title: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        }
    }
}
