//
//  WeatherData.swift
//  Clima
//
//  Created by Сымбат Майданова on 25.02.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}

struct Wind {
    let speed: Double
}


struct City: Codable {
    let en: String
    let kk: String
    let ru: String
}



