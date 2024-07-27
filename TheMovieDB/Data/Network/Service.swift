//
//  Service.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import Foundation

protocol ServiceProtocol {
    func fetchData(from url:URL, completion: @escaping (Result<(Data, Int, String?), Error>) -> Void)
}


class Service:ServiceProtocol {
    
    func fetchData(from url:URL, completion: @escaping (Result<(Data, Int, String?), Error>) -> Void){
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                print("Error al obtener datos: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid response")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error en la respuesta del servidor")
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                let errorMessage = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                completion(.success((Data(), httpResponse.statusCode, errorMessage)))
                return
            }
            
            completion(.success((data, httpResponse.statusCode, nil)))
        }.resume()
    }
}



