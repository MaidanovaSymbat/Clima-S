//
//  WeatherManager.swift
//  Clima
//
//  Created by Сымбат Майданова on 24.02.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a284ad0e76f35f63b94ab0587936e16b&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        //create URL
        if let url = URL(string: urlString) {
            //Create URL session
            let session = URLSession(configuration: .default)
            //Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let weather = self.parseJSON(weatherData: safeData) {
                        delegate?.
                    }
                }
            }
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: cityName, temperature: temp)
            
            print(weather.temperatureString)
        } catch {
            print("Error")
            return nil
        }
        
    }
    
}
