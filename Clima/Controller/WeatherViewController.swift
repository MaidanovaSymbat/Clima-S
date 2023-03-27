//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import Localize_Swift

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    
    @IBOutlet weak var humidityDataLabel: UILabel!
    
    
    @IBOutlet weak var feelDataLabel: UILabel!
    
    
    @IBOutlet weak var sunriseDataLabel: UILabel!
    
    @IBOutlet weak var KelvinLabel: UILabel!
    
    @IBOutlet weak var windDataLabel: UILabel!
    @IBOutlet weak var CelsiusLabel: UILabel!
    
    
    @IBOutlet weak var pressureDataLabel: UILabel!
    
    @IBOutlet weak var sunsetDataLabel: UILabel!
    
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        Localize.setCurrentLanguage("es")
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        //Use searchTextField.text to get the weather for that city
        searchTextField.text = ""
    }
    
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName.localized()
            self.windDataLabel.text = String(weather.speed)
            self.pressureDataLabel.text = String(weather.pressure)
            self.feelDataLabel.text = String(weather.feels_like)
            self.humidityDataLabel.text = String(weather.humidity)
            self.sunriseDataLabel.text = String(weather.sunrise)
            self.sunsetDataLabel.text = String(weather.sunset)
        }
        
        
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    lazy var celsius = Double(temperatureLabel.text!)!
    lazy var kelvin = Double(temperatureLabel.text!)! + 273
    
    @IBAction func CelsiusToKelvinTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            //result = kelvin as? String
            self.temperatureLabel.text = String(kelvin)
            self.KelvinLabel.text = "K"
            self.CelsiusLabel.text = ""
            print("Right")
        } else if sender.selectedSegmentIndex == 0 {
            celsius = kelvin - 273
            self.temperatureLabel.text = String(celsius)
            self.KelvinLabel.text = "C"
            self.CelsiusLabel.text = "°"
            print(sender.selectedSegmentIndex)
        }
    }
}
