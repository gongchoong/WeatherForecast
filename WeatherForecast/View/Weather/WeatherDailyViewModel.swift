//
//  WeatherDailyViewModel.swift
//  WeatherForecast
//
//  Created by David Lee on 9/2/23.
//

import Foundation
import Combine

class WeatherDailyViewModel: ObservableObject {
    @Published private var cityWithForecast: CityWithForecasts
    @Published var hourlyWeatherForecasts: [[LocalHourlyForecast]] = []
    
    
    init(cityWithForecast: CityWithForecasts) {
        self.cityWithForecast = cityWithForecast
        getLocalHourlyForecasts()
    }
    
    private func getLocalHourlyForecasts() {
        let localHourlyForecasts = self.$cityWithForecast
            .map { $0.weatherForecastHourly.properties.periods.map { LocalHourlyForecast(period: $0, city: self.cityWithForecast.city) } }
 
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        var index = 0
        var currentDateStr: String = ""
        let periodPublisher = localHourlyForecasts.map { localHourlyForecast in
            return localHourlyForecast.reduce(into: [[LocalHourlyForecast]]()) { partialResult, hourlyForecast in
                let dateStr = dateFormatter.string(from: hourlyForecast.startDate)
                if currentDateStr == "" {
                    currentDateStr = dateStr
                    partialResult.append([hourlyForecast])
                } else {
                    if dateStr != currentDateStr {
                        index += 1
                        currentDateStr = dateStr
                        partialResult.append([hourlyForecast])
                    } else {
                        partialResult[index].append(hourlyForecast)
                    }
                }
            }
        }
        periodPublisher
            .assign(to: &$hourlyWeatherForecasts)
    }
    
    func getDailyForecasts(index: Int) -> [LocalHourlyForecast] {
        return self.hourlyWeatherForecasts[index]
    }
    
    func getImageName(shortForecast: String) -> String {
        return WeatherType.check(shortForecast: shortForecast).imageName()
    }
    
    func getTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.string(from: date)
    }
    
    func getUpperBound(index: Int) -> Int {
        return self.hourlyWeatherForecasts[index].count
    }
    
    func getDate(index: Int) -> String {
        let startDate = self.hourlyWeatherForecasts[index].first?.startDate ?? Date()
        return Date.getMonthAndDay(date: startDate)
    }
    
    func increment(index: Int) -> Int {
        return index < self.hourlyWeatherForecasts.count - 1 ? 1 : 0
    }
    
    func decrement(index: Int) -> Int {
        return 0 < index ? 1 : 0
    }
}
