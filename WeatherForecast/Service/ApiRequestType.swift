//
//  ApiRequestType.swift
//  WeatherForecast
//
//  Created by David Lee on 8/18/23.
//

import Foundation

protocol ApiRequestType {
    associatedtype RequestType: Decodable
    
    var url: URL {get}
    var headers: [String: String]? {get}
}

struct CityRequest: ApiRequestType {
    typealias RequestType = Cities
    
    var url: URL
    var headers: [String : String]? = ["Accept": "application/ld+json"]
}

struct WeatherRequest: ApiRequestType {
    typealias RequestType = Weather
    
    var url: URL
    var headers: [String : String]? = ["Accept": "application/ld+json"]
}

struct WeatherForecastHourlyRequest: ApiRequestType {
    typealias RequestType = WeatherForecastHourly
    
    var url: URL
    var headers: [String : String]? = ["Accept": "application/ld+json"]
}
