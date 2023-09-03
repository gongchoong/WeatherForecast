//
//  WeatherDailyView.swift
//  WeatherForecast
//
//  Created by David Lee on 8/26/23.
//

import SwiftUI

struct WeatherDailyView: View {
    @ObservedObject private var weatherDailyViewModel: WeatherDailyViewModel
    @State var index: Int = 0
    
    init(cityWithForecast: CityWithForecasts) {
        self.weatherDailyViewModel = WeatherDailyViewModel(cityWithForecast: cityWithForecast)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.blue, .pink]), startPoint: .top, endPoint: .bottom)
                        .mask(Rectangle().cornerRadius(20))
                )
            VStack {
                HStack {
                    Button {
                        decrement()
                    } label: {
                        Text("< Previous")
                            .foregroundColor(.white)
                            .font(.custom("MavenPro-SemiBold", size: 18))
                    }
                    Spacer()
                    Text(self.weatherDailyViewModel.getDate(index: self.index))
                        .foregroundColor(.white)
                        .font(.custom("MavenPro-SemiBold", size: 18))
                    Spacer()
                    Button {
                        increment()
                    } label: {
                        Text("Next >")
                            .foregroundColor(.white)
                            .font(.custom("MavenPro-SemiBold", size: 18))
                    }
                }
                .padding(.all, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(self.weatherDailyViewModel.hourlyWeatherForecasts[self.index], id: \.id) { forecast in
                            WeatherHourlyView(imageName: self.weatherDailyViewModel.getImageName(shortForecast: forecast.shortForecast), time: self.weatherDailyViewModel.getTime(date: forecast.startDate), temperature: forecast.temperature, temperatureUnit: forecast.temperatureUnit)
                        }
                    }
                }
                .padding([.top, .bottom], 20)
                Spacer(minLength: 30)
            }
        }
    }
    
    func increment() {
        self.index += self.weatherDailyViewModel.increment(index: self.index)
    }
    
    func decrement() {
        self.index -= self.weatherDailyViewModel.decrement(index: self.index)
    }
}

struct WeatherHourlyView: View {
    var imageName: String
    var time: String
    var temperature: Int
    var temperatureUnit: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(30)
                .frame(width: 80)
            VStack {
                VStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .offset(y: 5)
                        .frame(width: 60, height: 60)
                        .padding(.bottom)
                    Text(time)
                        .foregroundColor(.white)
                        .font(.custom("MavenPro-SemiBold", size: 14))
                    Text("\(temperature)\u{00B0}\(temperatureUnit)")
                        .foregroundColor(.white)
                        .font(.custom("MavenPro-SemiBold", size: 14))
                }
                Spacer()
            }
        }
        .foregroundColor(.black)
        .padding([.leading])
    }
}
