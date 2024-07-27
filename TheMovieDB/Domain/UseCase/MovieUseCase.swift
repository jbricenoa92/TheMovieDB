//
//  MovieUseCase.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import Foundation
import UIKit


protocol MovieUseCaseProtocol {
    func fetchMovies(genre: String, page: Int, key: String, completion: @escaping (Result<[MovieDomain], Error>) -> Void)
}


class MovieUseCase: MovieUseCaseProtocol {
    
    
    private let repository: MoviesRepositoryProtocol
    private let imageRepository: ImagesRepositoryProtocol
    
    init(repository: MoviesRepositoryProtocol, imageRepository: ImagesRepositoryProtocol){
        self.repository = repository
        self.imageRepository = imageRepository
    }
    
    func fetchMovies(genre: String, page: Int, key: String, completion: @escaping (Result<[MovieDomain], Error>) -> Void) {
        
        repository.fetchMovies(genre: genre, page: page, key: key) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                let group = DispatchGroup()
                var movieViewModels: [MovieDomain] = []
                
                for movie in movies {
                    group.enter()
                    imageRepository.fetchImages(path: movie.posterPath) { imageResult in
                        var posterImage: UIImage? = nil
                        if case .success(let image) = imageResult {
                            posterImage = image
                        }
                        
                        let movieDomain = MovieDomain(movie: movie, image: posterImage)
                        
                        movieViewModels.append(movieDomain)
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    
                    completion(.success(movieViewModels))
                }
                
            case .failure(let error):
                print("Error fetching movies: \(error)")
                completion(.failure(error))
            }
        }
    }
    
}
