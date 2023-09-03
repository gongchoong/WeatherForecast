//
//  Date.swift
//  WeatherForecast
//
//  Created by David Lee on 9/2/23.
//

import Foundation

extension Date {
    func localTime(city: City) -> String {
        var calendar = Calendar.current
        
        if let utcTimeZone = TimeZone(abbreviation: "UTC") {
            calendar.timeZone = utcTimeZone
            if let utcDate = calendar.date(byAdding: .hour, value: city.UTC, to: self) {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = utcTimeZone
                dateFormatter.dateFormat = "hh:mm a"
                
                return dateFormatter.string(from: utcDate)
            }
        }
        
        return ""
    }
    
    func localDate(time: String, UTC: Int) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        var calendar = Calendar.current
        if let date = dateFormatter.date(from: time) {
            if let utcTimeZone = TimeZone(abbreviation: "UTC") {
                calendar.timeZone = utcTimeZone
                if let utcDate = calendar.date(byAdding: .hour, value: UTC, to: date) {
                    return utcDate
                }
            }
        }
        
        return Date()
    }
    
    static func getMonthAndDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        // Optionally, set the desired time zone
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let day = Calendar.current.component(.day, from: date)
        
        // Add the appropriate suffix based on the day of the month
        let daySuffix: String
        switch day {
        case 1, 21, 31:
            daySuffix = "st"
        case 2, 22:
            daySuffix = "nd"
        case 3, 23:
            daySuffix = "rd"
        default:
            daySuffix = "th"
        }
        
        return dateFormatter.string(from: date) + daySuffix
    }
}
