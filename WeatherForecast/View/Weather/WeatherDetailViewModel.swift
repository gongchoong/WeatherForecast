//
//  WeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by David Lee on 9/2/23.
//

import Foundation
import Combine

class WeatherDetailViewModel: ObservableObject {
    @Published var cityWithForecast: CityWithForecasts
    
    @Published var city: City?
    @Published var currentWeatherPeriod: Period?
    @Published var hourlyWeatherForecasts: [String:[LocalHourlyForecast]] = [:]
    @Published var shortForecast: String?
    @Published var windSpeed: String?
    @Published var temperature: Int?
    @Published var temperatureUnit: String?
    @Published var humidity: Int?
    @Published var imageName: String?
    
    
    init(cityWithForecast: CityWithForecasts) {
        self.cityWithForecast = cityWithForecast
        bind()
        getLocalHourlyForecasts()
    }
    
    private func bind() {
        self.$cityWithForecast
            .map { $0.city }
            .assign(to: &$city)
        self.$cityWithForecast
            .map { $0.weatherForecastHourly.properties.periods.first }
            .assign(to: &$currentWeatherPeriod)
        self.$currentWeatherPeriod
            .map { $0?.shortForecast }
            .assign(to: &$shortForecast)
        self.$currentWeatherPeriod
            .map { $0?.windSpeed }
            .assign(to: &$windSpeed)
        self.$currentWeatherPeriod
            .map { $0?.temperature }
            .assign(to: &$temperature)
        self.$currentWeatherPeriod
            .map { $0?.relativeHumidity.value }
            .assign(to: &$humidity)
        self.$currentWeatherPeriod
            .map { WeatherType.check(shortForecast: $0?.shortForecast ?? "").imageName() }
            .assign(to: &$imageName)
        self.$currentWeatherPeriod
            .map { $0?.temperatureUnit }
            .assign(to: &$temperatureUnit)
    }
    
    private func getLocalHourlyForecasts() {
        let localHourlyForecasts = self.$cityWithForecast
            .map { $0.weatherForecastHourly.properties.periods.map { LocalHourlyForecast(period: $0, city: self.cityWithForecast.city) } }
 
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let periodPublisher = localHourlyForecasts.map { localHourlyForecast in
            return localHourlyForecast.reduce(into: [String: [LocalHourlyForecast]]()) { partialResult, hourlyForecast in
                let dateStr = dateFormatter.string(from: hourlyForecast.startDate)
                if var existing = partialResult[dateStr] {
                    existing.append(hourlyForecast)
                    partialResult[dateStr] = existing
                } else {
                    partialResult[dateStr] = [hourlyForecast]
                }
            }
        }
        periodPublisher
            .assign(to: &$hourlyWeatherForecasts)
    }
}
