//
//  MainViewModel.swift
//  WeatherForecast
//
//  Created by David Lee on 8/18/23.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    private var apiService: ApiServiceProtocol
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    
    @Published var cityWithForecasts: [CityWithForecasts] = []
    var isFahrenheit = true
    
    init(apiService: ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
        
        bindCities()
    }
    
    func fetch() {
        onAppearSubject.send(())
    }
    
    private func bindCities() {
        guard let path = Bundle.main.path(forResource: Constants.cityJson, ofType: "json") else {
            return
        }
        
        onAppearSubject
            .flatMap { _ -> AnyPublisher<Cities, Error> in
                return self.apiService.requestForPath(request: CityRequest(url: URL(filePath: path)))
            }
            .map { $0.cities }
            .flatMap { cities -> AnyPublisher<[CityWithForecasts], Error> in
                let cityForecastPublishers = cities.map { [unowned self] city in
                    return self.fetchWeather(city: city)
                        .flatMap { [unowned self] weather in
                            return self.fetchHourlyForecast(weather: weather)
                        }.map { forecasts in
                            return CityWithForecasts(city: city, weatherForecastHourly: forecasts)
                        }.catch { error -> AnyPublisher<CityWithForecasts, Error> in
                            return Empty()
                                .setFailureType(to: Error.self)
                                .eraseToAnyPublisher()
                        }
                }
                return Publishers
                    .MergeMany(cityForecastPublishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { cityWithForecasts in

                self.cityWithForecasts = cityWithForecasts
            }).store(in: &cancellables)
    }
    
    private func fetchWeather(city: City) -> AnyPublisher<Weather, Error> {
        do {
            let address = Constants.weatherURL + "\(city.location.lat),\(city.location.lng)"
            guard let url = URL(string: address) else {
                throw ApiError.unableToGenerateURL
            }
            return self.apiService.request(request: WeatherRequest(url: url))
        } catch let error {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    private func fetchHourlyForecast(weather: Weather) -> AnyPublisher<WeatherForecastHourly, Error> {
        do {
            guard let forecastURL = URL(string: weather.properties.forecastHourly) else {
                throw ApiError.unableToGenerateURL
            }
            return self.apiService.request(request: WeatherForecastHourlyRequest(url: forecastURL))
        } catch let error {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func convert() {
        for index in self.cityWithForecasts.indices {
            for periodIndex in self.cityWithForecasts[index].weatherForecastHourly.properties.periods.indices {
                let temperature = self.cityWithForecasts[index].weatherForecastHourly.properties.periods[periodIndex].temperature
                if isFahrenheit {
                    self.cityWithForecasts[index].weatherForecastHourly.properties.periods[periodIndex].temperature = toCelsius(fahrenheit: temperature)
                    self.cityWithForecasts[index].weatherForecastHourly.properties.periods[periodIndex].temperatureUnit = Constants.celcius
                } else {
                    self.cityWithForecasts[index].weatherForecastHourly.properties.periods[periodIndex].temperature = toFahrenheit(celsius: temperature)
                    self.cityWithForecasts[index].weatherForecastHourly.properties.periods[periodIndex].temperatureUnit = Constants.fahrenheit
                }
            }
        }
        isFahrenheit = !isFahrenheit
    }
    
    private func toFahrenheit(celsius: Int) -> Int {
        let fahrenheit = Float(celsius) * 9/5 + 32
        return Int(fahrenheit.rounded())
    }
    
    private func toCelsius(fahrenheit: Int) -> Int {
        let celsius = Float(fahrenheit - 32) * 5/9
        return Int(celsius.rounded())
    }
}

