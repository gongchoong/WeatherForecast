//
//  MainViewModel.swift
//  WeatherForecast
//
//  Created by David Lee on 8/18/23.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    private var apiService: ApiServiceProtocol
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    
    @Published var cityWithForecasts: [CityWithForecasts] = []
    
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
        
        onAppearSubject.flatMap { _ -> AnyPublisher<Cities, Error> in
            return self.apiService.requestForPath(request: CityRequest(url: URL(filePath: path)))
        }
        .map { $0.cities }
        .flatMap { cities -> AnyPublisher<[CityWithForecasts], Error> in
            let cityForecastPublishers = cities.map { [unowned self] city in
                self.fetchWeather(city: city)
                    .flatMap { [unowned self] weather in
                        self.fetchHourlyForecast(weather: weather)
                    }.map { forecasts in
                        CityWithForecasts(city: city, forecasts: forecasts)
                    }
            }
            return Publishers.MergeMany(cityForecastPublishers).collect().eraseToAnyPublisher()
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
}

