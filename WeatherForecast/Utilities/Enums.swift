//
//  Enums.swift
//  WeatherForecast
//
//  Created by David Lee on 8/24/23.
//

import Foundation

enum WeatherType: String, CaseIterable {
    case rainShowers = "Rain Showers"
    case thunderstorms = "Thunderstorms"
    case sunny = "Sunny"
    case cloudy = "Cloudy"
    case clear = "Clear"
    case fog = "Fog"
    case snow = "Snow"
    
    static func check(shortForecast: String) -> WeatherType {
        return WeatherType.allCases.first { shortForecast.contains($0.rawValue) } ?? .sunny
    }
    
    func imageName() -> String {
        switch self {
        case .rainShowers:
            return ImageName.rain.rawValue
        case .thunderstorms:
            return ImageName.thunderstorms.rawValue
        case .sunny:
            return ImageName.sunny.rawValue
        case .cloudy:
            return ImageName.cloudy.rawValue
        case .clear:
            return ImageName.sunny.rawValue
        case .fog:
            return ImageName.fog.rawValue
        case .snow:
            return ImageName.snow.rawValue
        }
    }
}

enum ImageName: String {
    case rain
    case thunderstorms
    case sunny
    case cloudy
    case fog
    case snow
    
    
}
