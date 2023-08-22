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
                CityView(cityWithForecasts: cityWithForecasts)
            })
            .navigationTitle(Constants.title)
        }
        .onAppear(perform: { mainViewModel.fetch() })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
