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
    let relativeHumidity: RelativeHumidity
}

struct RelativeHumidity: Decodable {
    let value: Int
}
