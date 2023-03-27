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
           let language = Locale.current.languageCode ?? "en"
           let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
           let url = "\(weatherURL)&q=\(encodedCityName)&lang=\(language)"
           performRequest(with: url)
       }
    
    
    func performRequest(with url: String) {
            AF.request(url).validate().response { response in
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
    
    
  
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let json = JSON(weatherData)
        let id = json["weather"][0]["id"].intValue
        let temp = json["main"]["temp"].doubleValue
        let cityNameEn = json["name"].stringValue // Получаем английское название города
        let speed = json["wind"]["speed"].doubleValue
        let feels_like = json["main"]["feels_like"].doubleValue
        let pressure = json["main"]["pressure"].intValue
        let humidity = json["main"]["humidity"].intValue
        let sunrise = json["sys"]["sunrise"].intValue
        let sunset = json["sys"]["sunset"].intValue
        // Загружаем JSON-файл с названиями городов на разных языках
        if let path = Bundle.main.path(forResource: "cities", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let jsonCityNames = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: String]] {
            let language = Locale.current.languageCode ?? "en"// Получаем текущий язык, если его нет, используем английский
            let cityNameLocalized = jsonCityNames[cityNameEn]?[language] ?? cityNameEn // Переводим название города на нужный язык, если перевода нет, используем английское название
            let weather = WeatherModel(conditionID: id, cityName: cityNameLocalized, temperature: temp, speed: speed, feels_like: feels_like, pressure: pressure, humidity: humidity, sunrise: sunrise, sunset: sunset)
            return weather
        }

        return nil
    }
    
}





