//
//  ApiService.swift
//  WeatherForecast
//
//  Created by David Lee on 8/18/23.
//

import Foundation
import Combine

class ApiService: ApiServiceProtocol {
    func request<T>(request: T) -> AnyPublisher<T.RequestType, Error> where T: ApiRequestType {
        let urlRequest = URLRequest(url: request.url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .retry(2)
            .tryMap {
                guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                    throw ApiError.unknownResponse
                }

                guard (200..<300).contains(code) else {
                    throw ApiError.httpError(code: code)
                }

                return $0.data
            }
            .decode(type: T.RequestType.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func requestForPath<T>(request: T) -> AnyPublisher<T.RequestType, Error> where T: ApiRequestType {
        let urlRequest = URLRequest(url: request.url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap {
                return $0.data
            }
            .decode(type: T.RequestType.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
