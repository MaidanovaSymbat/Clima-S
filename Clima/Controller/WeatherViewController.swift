//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var KelvinLabel: UILabel!
    
    @IBOutlet weak var CelsiusLabel: UILabel!
    
    
    var weather: WeatherModel
    
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
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
            self.cityLabel.text = weather.cityName
            
        }
   
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    @IBAction func CelsiusToKelvinTapped(_ sender: UISegmentedControl) {
        var result = Double(self.temperatureLabel.text!)!
        let kelvin = Double(result) + 273.15
        let celsius = kelvin - 273.15
        if sender.selectedSegmentIndex == 1 {
            self.temperatureLabel.text = String(kelvin)
            self.KelvinLabel.text = "K"
            self.CelsiusLabel.text = ""
            print("Right")
            
        } else if sender.selectedSegmentIndex == 0 {
            self.temperatureLabel.text = weather.temperatureString
            self.temperatureLabel.text = String(celsius)
            self.KelvinLabel.text = "C"
            self.CelsiusLabel.text = "°"
            print("Pressed")
        }
        
    }
    
//    func reset() {
//        // сбросить все изменения
//        self.temperatureLabel.text =
//        switch1.isOn = false
//        switch2.isOn = false
//    }
//
//    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            reset()
//        }
//    }
//
//    sender.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
}

