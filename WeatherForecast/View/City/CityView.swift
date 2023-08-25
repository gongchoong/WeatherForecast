//
//  CityView.swift
//  WeatherForecast
//
//  Created by David Lee on 8/21/23.
//

import SwiftUI

struct CityView: View {
    
    let cityWithForecasts: CityWithForecasts
    let currentWeather: Period?
    
    init(cityWithForecasts: CityWithForecasts) {
        self.cityWithForecasts = cityWithForecasts
        self.currentWeather = cityWithForecasts.currentWeather
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(cityWithForecasts.city.name)")
                    .font(.title)
                Text("United States")
                    .font(.caption)
            }
            Spacer()
            VStack {
                HStack {
                    Text("\(self.currentWeather?.temperature ?? 0) \u{00B0}\(self.currentWeather?.temperatureUnit ?? "")")
                    Image(systemName: self.currentWeather?.weatherImageName.rawValue ?? ImageName.sunny.rawValue)
                }
                Text(self.cityWithForecasts.currentTimeInUTC)
                    .font(.caption)
            }
        }
    }
}

