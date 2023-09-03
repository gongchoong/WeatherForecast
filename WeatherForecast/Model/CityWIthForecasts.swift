//
//  CityWIthForecasts.swift
//  WeatherForecast
//
//  Created by David Lee on 8/22/23.
//

import Foundation

struct CityWithForecasts: Identifiable {
    let city: City
    var weatherForecastHourly: WeatherForecastHourly
    
    init(city: City, weatherForecastHourly: WeatherForecastHourly) {
        self.city = city
        self.weatherForecastHourly = weatherForecastHourly
    }
    
    var currentWeather: Period? {
        return weatherForecastHourly.properties.periods.first
    }
    
    var id: Int {
        city.id
    }
}
