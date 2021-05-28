//
//  NetworkManager.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.weatherapi.com/v1/forecast.json?key=0c42e93b2a414fc89a031747212505&aqi=no&alerts=no&days=3"
    
    private init() {}
    
    func getForecast(for location: String, completed: @escaping (Result<WeatherForecast, FRError>) -> Void) {
        let endpoint = "\(baseURL)&q=\(location)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidLocation))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let forecast = try decoder.decode(WeatherForecast.self, from: data)
                completed(.success(forecast))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
}
