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
            filterMovies(startingWith: searchLetter, data: moviesData)
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
    var onlyAdult: Bool = false {
        didSet {
            moviesData = []
            leakedMovies = []
            loadMoviesData()
        }
    }
    var genre = "popular"
    var page = 1
    // agregar apiKey
    var apiKey = ""
    @Published var movieSelected: [MovieDomain] = []
    
    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func filterMovies(startingWith letter: String, data datas: [MovieDomain] ) {
        
        let filteredList = datas.filter { movie in
            movie.originalTitle.lowercased().hasPrefix(letter.lowercased()) ||  movie.title.lowercased().hasPrefix(letter.lowercased())
        }
        self.leakedMovies = filteredList
    }
    
    
    func filterMoviesOnlyAdult(startingWith letter: String ) {
      
        var filteredList = moviesData
        if(onlyAdult){
           
         return filteredList = moviesData.filter { movie in
                movie.adult == true
            }
        }
      filterMovies(startingWith: letter, data: filteredList)
    }
    
    func loadMoviesData(){
        useCase.fetchMovies(genre: genre, page: page, key: apiKey){ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.moviesData.append(contentsOf: movies)
                    self?.filterMoviesOnlyAdult(startingWith: self?.searchLetter ?? "")
                    self?.onMoviesUpdated?()
                    self?.page += 1
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
