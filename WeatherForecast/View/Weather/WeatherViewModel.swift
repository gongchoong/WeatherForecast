//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by David Lee on 9/2/23.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published private var cityWithForecast: CityWithForecasts
    
    @Published var city: City?
    @Published var localTime: String?
    @Published var temperature: Int?
    @Published var temperatureUnit: String?
    @Published var imageName: String?
    
    
    init(cityWithForecast: CityWithForecasts) {
        self.cityWithForecast = cityWithForecast
        bind()
    }
    
    func bind() {
        self.$cityWithForecast
            .map { $0.city }
            .assign(to: &$city)
        self.$cityWithForecast
            .map { Date().localTime(city: $0.city) }
            .assign(to: &$localTime)
        let currentWeather = self.$cityWithForecast
            .map { $0.weatherForecastHourly.properties.periods.first }
        currentWeather
            .map { $0?.temperature }
            .assign(to: &$temperature)
        currentWeather
            .map { $0?.temperatureUnit }
            .assign(to: &$temperatureUnit)
        currentWeather
            .map { WeatherType.check(shortForecast: $0?.shortForecast ?? "").imageName() }
            .assign(to: &$imageName)
    }
}
