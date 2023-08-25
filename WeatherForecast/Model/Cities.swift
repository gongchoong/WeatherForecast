//
//  Cities.swift
//  WeatherForecast
//
//  Created by David Lee on 8/21/23.
//

import Foundation

struct Cities: Decodable {
    let cities: [City]
}

struct City: Decodable, Identifiable {
    let id: Int
    let name: String
    let location: Location
    let UTC: Int
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}
