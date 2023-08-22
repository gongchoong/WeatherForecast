//
//  CityView.swift
//  WeatherForecast
//
//  Created by David Lee on 8/21/23.
//

import SwiftUI

struct CityView: View {
    
    let cityWithForecasts: CityWithForecasts
    
    init(cityWithForecasts: CityWithForecasts) {
        self.cityWithForecasts = cityWithForecasts
    }
    
    var body: some View {
        HStack {
            Text(cityWithForecasts.city.name)
            Text("\(cityWithForecasts.forecasts.properties.periods.first?.endDate ?? Date())")
        }
    }
}

