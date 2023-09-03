//
//  MainView.swift
//  WeatherForecast
//
//  Created by David Lee on 8/21/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            List(mainViewModel.cityWithForecasts, rowContent: { cityWithForecasts in
                WeatherView(cityWithForecasts: cityWithForecasts)
                    .frame(height: 100)
                    .listRowBackground(Color.clear)
            })
            .navigationTitle(Constants.title)
            .toolbar {
                Button {
                    mainViewModel.convert()
                } label: {
                    mainViewModel.isFahrenheit ? Text("\u{00B0}C") : Text("\u{2109}")
                }
                .padding(.trailing)
            }
        }
        .onAppear(perform: { mainViewModel.fetch() })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
