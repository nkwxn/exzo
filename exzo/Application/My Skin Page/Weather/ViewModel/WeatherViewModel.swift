//
//  WeatherViewModel.swift
//  WeatherAPITest
//
//  Created by Daniella Stefani on 08/11/21.
//

import Foundation
import CoreLocation
import MapKit

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var fetchStatus: FetchWeatherStatus = .loading
    @Published var cityName = ""
    @Published var tempString = ""
    @Published var weatherDesc = ""
    @Published var humidityString = ""
    @Published var iconLink = ""
    @Published var recommendationString = ""
    
    var locationManager: CLLocationManager?
    
    // MARK: - Check the Location Services if it's enabled
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            checkLocationAuthorization()
        } else {
            print("Error: service disabled")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager
        else {
            return
        }
        
        switch locationManager.authorizationStatus {
        // open the permission window
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location restricted likely due to parental control")
            self.fetchStatus = .error
        case .denied:
            print("Permission denied. Please go to settings")
            self.fetchStatus = .error
        // when it is on, load everything
        case .authorizedAlways, .authorizedWhenInUse:
            loadWeather()
        @unknown default:
            break
        }
    }
    
    // MARK: - Load weather from the API
    func loadWeather() {
        guard let locationManager = locationManager
        else {
            return
        }
        self.fetchStatus = .loading
        
        APIRequest.fetchWeather(coordinate: locationManager.location!.coordinate) { data in
            self.updateWeatherData(data)
        } failCompletion: { error in
            print(error)
            self.fetchStatus = .error
        }
    }
    
    // MARK: - Update the label to the current weather
    func updateWeatherData(_ data: FetchedData) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if NSLocale.autoupdatingCurrent.identifier.hasSuffix("US") {
                self.tempString = "\(data.main.temp)°F"
            } else {
                self.tempString = "\(data.main.temp)°C"
            }
            self.cityName = "\(data.name)"
            self.humidityString = "\(data.main.humidity)%"
            self.weatherDesc = data.weather[0].main
            self.iconLink = "https://openweathermap.org/img/wn/" + "\(data.weather[0].icon)" + "@2x.png"
            self.recommendationString = self.getRecommendationString(withWeather: self.weatherDesc, temperature: data.main.temp)
        }
        self.fetchStatus = .done
        print("\(self.tempString), \(self.humidityString), \(self.weatherDesc), \(self.iconLink)")
    }
    
    // TODO: change to motivational quotes, not recommendation
    func getRecommendationString(withWeather desc: String, temperature temp: Double) -> String {
        
        switch desc {
        case "Clear":
            if temp >= 30.0 {
                return "Cool down from the heat to prevent sweating! Don't forget to use sunscreen."
            } else {
                return "Make sure to wear breathable clothes for today. Don't forget to use sunscreen."
            }
        case "Clouds":
            if temp >= 30.0 {
                return "Cool down from the heat to prevent sweating!"
            } else {
                let recommendations = ["Make sure to wear breathable clothes for today.", "Don't forget to moisturize your skin."]
                let recommendation = recommendations.randomElement()!
                return recommendation
            }
        case "Rain":
            let recommendations = ["Don't forget to moisturize your skin.", "Stay away from rain drops, it might flare you up."]
            let recommendation = recommendations.randomElement()!
            return recommendation
        case "Mist":
            return "Don't forget to moisturize your skin."
        case "Thunderstorm":
            return "Stay away from rain drops, it might flare you up."
        default:
            return "Exzo helps you manage your eczema."
        }
    }
    
    enum FetchWeatherStatus {
        case loading, done, error
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
