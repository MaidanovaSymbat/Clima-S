//
//  WeatherModel.swift
//  Clima
//
//  Created by Сымбат Майданова on 26.02.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel {
    let conditionID: Int
    var cityName: String
    let temperature: Double
    let speed: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let sunrise: Int
    let sunset: Int
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
