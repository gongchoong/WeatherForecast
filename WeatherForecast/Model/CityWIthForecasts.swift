//
//  CityWIthForecasts.swift
//  WeatherForecast
//
//  Created by David Lee on 8/22/23.
//

import Foundation

struct CityWithForecasts: Identifiable {
    let city: City
    let forecasts: WeatherForecastHourly
    
    var id: Int {
        city.id
    }
}
