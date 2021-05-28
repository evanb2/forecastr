//
//  Forecast.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import Foundation

struct WeatherForecast: Codable {
    let current: Current
    let forecast: Forecast
}

struct Current: Codable {
    let tempC: Float
    let tempF: Float
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
}

struct Day: Codable {
    let maxtempC: Float
    let maxtempF: Float
    let mintempC: Float
    let mintempF: Float
    let avgtempC: Float
    let avgtempF: Float
    let dailyChanceOfRain: String
    let dailyChanceOfSnow: String
    let condition: Condition
}
