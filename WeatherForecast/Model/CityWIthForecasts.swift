//
//  CityWIthForecasts.swift
//  WeatherForecast
//
//  Created by David Lee on 8/22/23.
//

import Foundation

struct CityWithForecasts: Identifiable {
    let city: City
    var forecasts: WeatherForecastHourly
    
    var currentWeather: Period? {
        return forecasts.properties.periods.first
    }
    
    var id: Int {
        city.id
    }
    
    var currentTimeInUTC: String {
        var calendar = Calendar.current
        let currentDate = Date()
        
        if let utcTimeZone = TimeZone(abbreviation: "UTC") {
            calendar.timeZone = utcTimeZone
            if let utcDate = calendar.date(byAdding: .hour, value: city.UTC, to: currentDate) {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = utcTimeZone
                dateFormatter.dateFormat = "hh:mm a"
                
                return dateFormatter.string(from: utcDate)
            }
        }
        
        return ""
    }
}
