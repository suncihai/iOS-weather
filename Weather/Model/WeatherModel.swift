//
//  ContentView.swift
//  Weather
//
//  Created by cihai sun on 2/8/25.
//

import Foundation

// 定义天气数据结构
struct Weather: Codable {
    let temperature: Double
    let humidity: Double
}

// Add these new structures to match the API response
struct WeatherResponse: Codable {
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let humidity: Double
}

// 负责调用 API 获取天气数据
class WeatherModel {
    private let apiKey = "858c6ef56e174c7ea0b02859250902"
    private let baseURL = "https://api.weatherapi.com/v1/current.json"
    
    func fetchWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        let urlString = "\(baseURL)?key=\(apiKey)&q=\(city)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                // Update the decoding to use the new structures
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                let weather = Weather(
                    temperature: weatherResponse.current.temp_c,
                    humidity: weatherResponse.current.humidity
                )
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
