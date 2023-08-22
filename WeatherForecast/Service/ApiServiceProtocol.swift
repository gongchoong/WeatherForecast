//
//  ApiServiceProtocol.swift
//  WeatherForecast
//
//  Created by David Lee on 8/18/23.
//

import Foundation
import Combine

enum ApiError: Error {
    case unableToGenerateURL
    case unknownResponse
    case httpError(code: Int)
    case decodingError
}

protocol ApiServiceProtocol {
    func request<T>(request: T) -> AnyPublisher<T.RequestType, Error> where T: ApiRequestType
    func requestForPath<T>(request: T) -> AnyPublisher<T.RequestType, Error> where T: ApiRequestType
}
