//
//  Weather.swift
//  WeatherForecast
//
//  Created by David Lee on 8/22/23.
//

import Foundation

struct Weather: Decodable {
    let properties: WeatherProperties
}

struct WeatherProperties: Decodable {
    let forecast: String
    let forecastHourly: String
}

struct WeatherForecastHourly: Decodable {
    let properties: HourlyProperties
}

struct HourlyProperties: Decodable {
    let periods: [Period]
}

struct Period: Decodable {
    let startTime: String
    let endTime: String
    let temperature: Int
    let temperatureUnit: String
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
}
