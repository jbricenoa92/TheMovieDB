//
//  GetMovies.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import Foundation


protocol MoviesRepositoryProtocol {
    func fetchMovies(genre: String, page: Int, key: String, completion: @escaping (Result<([Movie]), Error>) -> Void)
}

class MovieRepository: MoviesRepositoryProtocol {
    
    private let service: ServiceProtocol
    
    init(service:ServiceProtocol){
        self.service = service
    }
    
    
    func fetchMovies(genre: String, page: Int, key: String, completion: @escaping (Result<([Movie]), Error>) -> Void) {
       
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(genre)?language=es-ES&page=\(page)&include_adult=true&api_key=\(key)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        service.fetchData(from: url) { result in
            
            switch result {
            case .success(let (data, statusCode, message)):
                if (200...299).contains(statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(MovieResponse.self, from: data)
                        completion(.success(response.results))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    // Puedes definir un error personalizado o usar uno existente
                    let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: message ?? "Network error"])
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
