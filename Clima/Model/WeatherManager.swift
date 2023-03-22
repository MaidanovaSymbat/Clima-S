//
//  WeatherManager.swift
//  Clima
//
//  Created by Сымбат Майданова on 24.02.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Localize_Swift



protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a284ad0e76f35f63b94ab0587936e16b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    
//    func performRequest(with urlString: String) {
//        //create URL
//        if let url = URL(string: urlString) {
//            //Create URL session
//            let session = URLSession(configuration: .default)
//            //Give the session a task
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                    return
//                }
//
//                if let safeData = data {
//                    if let weather = self.parseJSON(safeData) {
//                        self.delegate?.didUpdateWeather(self, weather: weather)
//                    }
//                }
//            }
//            //Start the task
//            task.resume()
//        }
//    }
    
    func performRequest(with urlString: String) {
        AF.request(urlString).validate().response { response in
            switch response.result {
            case .success(let data):
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    
//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
//            let cityName = decodedData.name
//
//            let weather = WeatherModel(conditionID: id, cityName: cityName, temperature: temp)
//
//            print(weather.temperatureString)
//            print(weather.conditionName)
//            return weather
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//
//    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let json = JSON(weatherData)
        let id = json["weather"][0]["id"].intValue
        let temp = json["main"]["temp"].doubleValue
        let cityName = json["name"].stringValue
        

        let weather = WeatherModel(conditionID: id, cityName: cityName, temperature: temp)

        print(weather.temperatureString)
        print(weather.conditionName)
        print(weather.cityName)

        return weather

    }
    
}





