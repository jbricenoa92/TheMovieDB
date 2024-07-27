//
//  Di.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//


import Foundation

class DependencyInjector {
    
    static let shared = DependencyInjector()
    
    private init(){}
    
    func provideService() -> ServiceProtocol {
        return Service()
    }
    
    func provideMovieRepository()  -> MoviesRepositoryProtocol {
        return MovieRepository(service: provideService())
    }
    
    func provideImageRepository()  -> ImagesRepositoryProtocol {
        return ImagesRepository(service: provideService())
    }
    
    func provideMovieUseCase() -> MovieUseCaseProtocol {
        return MovieUseCase(repository: provideMovieRepository(), imageRepository: provideImageRepository())
    }
    
    func provideMovieViewModel() -> MovieViewModelProtocol {
        return MovieViewModel(useCase: provideMovieUseCase())
    }
    
    
}

