//
//  ContentView.swift
//  Weather
//
//  Created by cihai sun on 2/8/25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city: String = "New_York"
    
    var body: some View {
        VStack {
            TextField("Enter city", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Fetch Weather") {
                viewModel.fetchWeather(for: city)
            }
            .padding()
            
            Text(viewModel.temperatureText)
                .font(.title)
            Text(viewModel.humidityText)
                .font(.title)
        }
        .padding()
    }
}
