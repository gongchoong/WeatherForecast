//
//  WeatherDetailView.swift
//  WeatherForecast
//
//  Created by David Lee on 8/26/23.
//

import SwiftUI

struct WeatherDetailView: View {
    
    @ObservedObject private var weatherDetailViewModel: WeatherDetailViewModel
    private var cityWithForecasts: CityWithForecasts
    
    init(cityWithForecasts: CityWithForecasts) {
        self.cityWithForecasts = cityWithForecasts
        self.weatherDetailViewModel = WeatherDetailViewModel(cityWithForecast: cityWithForecasts)
    }
    
    var body: some View {
        VStack {
            Text(self.weatherDetailViewModel.city?.name ?? "")
                .font(.custom("MavenPro-SemiBold", size: 40))
            Spacer()
            Image(self.weatherDetailViewModel.imageName ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text(self.weatherDetailViewModel.shortForecast ?? "")
                .font(.custom("MavenPro-SemiBold", size: 20))
                .padding([.leading, .trailing, .bottom])
            WeatherDetailInfoView(windSpeed: self.weatherDetailViewModel.windSpeed ?? "",
                                  temperature: self.weatherDetailViewModel.temperature ?? 0,
                                  humidity: self.weatherDetailViewModel.humidity ?? 0,
                                  temperatureUnit: self.weatherDetailViewModel.temperatureUnit ?? "")
            .padding([.leading, .trailing])
            WeatherDailyView(cityWithForecast: cityWithForecasts)
                .padding([.leading, .trailing, .bottom])
        }
        .onAppear {
        }

    }
}

struct WeatherDetailInfoView: View {
    let windSpeed: String
    let temperature: Int
    let humidity: Int
    let temperatureUnit: String
    
    var body: some View {
        HStack {
            VStack {
                Text("Wind")
                    .font(.custom("MavenPro-Regular", size: 16))
                Text(self.windSpeed)
                    .font(.custom("MavenPro-SemiBold", size: 24))
            }
            .padding(.leading)
            Spacer()
            VStack {
                Text("Temp")
                    .font(.custom("MavenPro-Regular", size: 16))
                Text("\(self.temperature)\u{00B0}\(self.temperatureUnit)")
                    .font(.custom("MavenPro-SemiBold", size: 24))
            }
            Spacer()
            VStack {
                Text("Humidity")
                    .font(.custom("MavenPro-Regular", size: 16))
                Text("\(self.humidity)%")
                    .font(.custom("MavenPro-SemiBold", size: 24))
            }
            .padding(.trailing)
        }
    }
}
