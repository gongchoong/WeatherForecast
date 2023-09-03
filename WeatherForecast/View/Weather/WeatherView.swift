//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by David Lee on 8/21/23.
//

import SwiftUI
import Combine

struct WeatherView: View {
    @ObservedObject private var weatherViewModel: WeatherViewModel
    private var cityWithForecasts: CityWithForecasts
    
    init(cityWithForecasts: CityWithForecasts) {
        self.cityWithForecasts = cityWithForecasts
        self.weatherViewModel = WeatherViewModel(cityWithForecast: cityWithForecasts)
    }
    
    var body: some View {
        NavigationLink {
            WeatherDetailView(cityWithForecasts: self.cityWithForecasts)
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(self.weatherViewModel.city?.name ?? "")")
                        .font(.custom("MavenPro-SemiBold", size: 28))
                    Text("United States")
                        .font(.custom("MavenPro-SemiBold", size: 14))
                }
                Spacer()
                VStack {
                    HStack {
                        Text("\(self.weatherViewModel.temperature ?? 0)\u{00B0}\(self.weatherViewModel.temperatureUnit ?? "")")
                            .font(.custom("MavenPro-SemiBold", size: 36))
                        Image(self.weatherViewModel.imageName ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    }
                    Text("\(self.weatherViewModel.localTime ?? "")")
                        .font(.custom("MavenPro-SemiBold", size: 14))
                }
            }
        }

    }
}

