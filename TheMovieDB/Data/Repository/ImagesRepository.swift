//
//  ImagesRepository.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import Foundation
import UIKit

protocol ImagesRepositoryProtocol {
    func fetchImages(path: String, completion: @escaping (Result<(UIImage), Error>) -> Void)
}

class ImagesRepository: ImagesRepositoryProtocol {
    //
    private let service: ServiceProtocol
    
    init(service:ServiceProtocol){
        self.service = service
    }
    
    func fetchImages(path: String, completion: @escaping (Result<(UIImage), any Error>) -> Void) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        service.fetchData(from: url) { result in
            
            switch result {
            case .success(let (data, statusCode, message)):
                if (200...299).contains(statusCode) {
                    do {
                        if let image = UIImage(data: data) {
                            completion(.success(image))
                        } else {
                            completion(.failure(NSError(domain: "Image Conversion Error", code: -1, userInfo: nil)))
                        }
                        
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
