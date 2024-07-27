//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import Foundation

protocol MovieViewModelProtocol {
    var moviesData: [MovieDomain] { get }
    var onMoviesUpdated: (() -> Void)? { get set }
    var isFetchingMore: Bool { get }
    func loadMoviesData()
}

class MovieViewModel: MovieViewModelProtocol {
    
    
    private let useCase: MovieUseCaseProtocol
    var isFetchingMore = false
    var searchLetter = "" {
        didSet {
            filterMovies(startingWith: searchLetter)
        }
    }
    var onMoviesUpdated: (() -> Void)?
    var moviesData: [MovieDomain] = []
    var errorMessage: String? = nil
    var leakedMovies:[MovieDomain] = []{
        didSet {
            onMoviesUpdated?()
        }
    }
    var genre = "popular"
    var page = 1
    var apiKey = "24f9cb64fa5f85e63c0ff008c04b2cd8"
    @Published var MovieSelected: [MovieDomain] = []
    
    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func filterMovies(startingWith letter: String ) {
        
        let filteredList = moviesData.filter { movie in
            movie.originalTitle.lowercased().hasPrefix(letter.lowercased()) ||  movie.title.lowercased().hasPrefix(letter.lowercased())
        }
        self.leakedMovies = filteredList
    }
    
    func loadMoviesData(){
        useCase.fetchMovies(genre: genre, page: page, key: apiKey){ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.moviesData.append(contentsOf: movies)
                    self?.filterMovies(startingWith: self?.searchLetter ?? "")
                    self?.onMoviesUpdated?()
                    self?.page += 1
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
