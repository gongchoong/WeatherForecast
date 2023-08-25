//
//  Weather.swift
//  WeatherForecast
//
//  Created by David Lee on 8/22/23.
//

import Foundation

struct Weather: Decodable {
    var properties: WeatherProperties
}

struct WeatherProperties: Decodable {
    let forecast: String
    var forecastHourly: String
}

struct WeatherForecastHourly: Decodable {
    var properties: HourlyProperties
}

struct HourlyProperties: Decodable {
    var periods: [Period]
}

struct Period: Decodable {
    let startTime: String
    let endTime: String
    var temperature: Int
    var temperatureUnit: String
    let shortForecast: String
    let windSpeed: String
    let windDirection: String
    
    func convertToDate(dateString: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: dateString) ?? Date()
    }

    var startDate: Date {
        return convertToDate(dateString: startTime)
    }

    var endDate: Date {
        return convertToDate(dateString: endTime)
    }
    
    var weatherImageName: ImageName {
        if shortForecast.contains(WeatherType.rainShowers.rawValue) {
            return ImageName.rain
        }
        if shortForecast.contains(WeatherType.thunderstorms.rawValue) {
            return ImageName.thunderstorms
        }
        if shortForecast.contains(WeatherType.sunny.rawValue) {
            return ImageName.sunny
        }
        if shortForecast.contains(WeatherType.cloudy.rawValue) {
            return ImageName.cloudy
        }
        if shortForecast.contains(WeatherType.clear.rawValue) {
            return ImageName.sunny
        }
        if shortForecast.contains(WeatherType.fog.rawValue) {
            return ImageName.fog
        }
        if shortForecast.contains(WeatherType.snow.rawValue) {
            return ImageName.snow
        }
        
        return ImageName.sunny
    }
}
