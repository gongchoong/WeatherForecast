//
//  HourlyForecast.swift
//  WeatherForecast
//
//  Created by David Lee on 9/1/23.
//

import Foundation

struct LocalHourlyForecast: Identifiable {
    var id: UUID = UUID()
    let startDate: Date
    let endDate: Date
    var temperature: Int
    var temperatureUnit: String
    let shortForecast: String
    let windSpeed: String
    let windDirection: String
    let relativeHumidity: RelativeHumidity
    let city: City
    
    init(period: Period, city: City) {
        self.startDate = Date().localDate(time: period.startTime, UTC: city.UTC)
        self.endDate = Date().localDate(time: period.endTime, UTC: city.UTC)
        self.temperature = period.temperature
        self.temperatureUnit = period.temperatureUnit
        self.shortForecast = period.shortForecast
        self.windSpeed = period.windSpeed
        self.windDirection = period.windDirection
        self.relativeHumidity = period.relativeHumidity
        self.city = city
    }
}
