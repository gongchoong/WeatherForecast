//
//  Enums.swift
//  WeatherForecast
//
//  Created by David Lee on 8/24/23.
//

import Foundation

enum WeatherType: String {
    case rainShowers = "Rain Showers"
    case thunderstorms = "Thunderstorms"
    case sunny = "Sunny"
    case cloudy = "Cloudy"
    case clear = "Clear"
    case fog = "Fog"
    case snow = "Snow"
}

enum ImageName: String {
    case rain = "cloud.rain"
    case thunderstorms = "cloud.bolt.rain"
    case sunny = "sun.max"
    case cloudy = "cloud"
    case fog = "cloud.fog"
    case snow = "cloud.snow"
}
