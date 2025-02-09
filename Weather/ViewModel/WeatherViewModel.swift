//
//  ContentView.swift
//  Weather
//
//  Created by cihai sun on 2/8/25.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var temperatureText: String = "Loading..."
    @Published var humidityText: String = "Loading..."
    
    private let model = WeatherModel()
    
    func fetchWeather(for city: String) {
        model.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.temperatureText = "Temperature: \(weather.temperature)°C"
                    self?.humidityText = "Humidity: \(weather.humidity)%"
                case .failure(let error):
                    self?.temperatureText = "Failed to load data"
                    self?.humidityText = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
