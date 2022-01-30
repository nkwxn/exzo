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
    
    var locationManager: CLLocationManager?
    
    // Encouragement words
    let encouragements: [String] = [
        "4 dari 5 anak akan sembuh dari eksim",
        "Jangan bersedih, ada 80% kemungkinan anak mu sembuh dari eksim!",
        "Anak yang ceria akan membuat kulit yang lebih sehat!",
        "Kulit yang lembab adalah kunci!",
        "Ruangan yang bersih akan mengurangi resiko untuk kulit kambuh!",
        "Sepertinya terlihat ada perubahan cuaca, perhatikan kulit anak mu ya.",
        "Katakan secara lantang: \"Aku akan sembuh dari eksim!\"",
        "Jika ingin sehat dari luar harus dimulai dalam",
        "Perjuanganmu ini tidak sendiri",
        "Saat kamu fokus di hal yang baik, hal yang baik akan menjadi semakin baik",
        "Pemandangan terbaik datang setelah pendakian yang sulit",
        "Walaupun hanya sedikit membaik itu tetap membaik, harus semangat!"
    ]
    
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
        let geocoder = CLGeocoder()
        guard let location = locationManager?.location
        else {
            return
        }
        print(location)
        
        self.fetchStatus = .loading
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            let placemark = placemarks?[0]
            APIRequest.fetchWeather(cityName: placemark?.locality ?? "") { data in
                self.fetchStatus = .done
                self.updateWeatherData(data)
            } failCompletion: { error in
                print(error)
                self.fetchStatus = .error
            }
        }
        
        APIRequest.fetchWeather(coordinate: location.coordinate) { data in
            self.fetchStatus = .done
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
            self.weatherDesc = data.weather[0].description.capitalized
            self.iconLink = "https://openweathermap.org/img/wn/" + "\(data.weather[0].icon)" + "@2x.png"
        }
        self.fetchStatus = .done
        print("\(self.tempString), \(self.humidityString), \(self.weatherDesc), \(self.iconLink)")
    }
    
    // TODO: change to motivational quotes, not recommendation
    func getMotivationKeyword() -> String {
        return encouragements[Int.random(in: 0..<encouragements.count)]
    }
    
    enum FetchWeatherStatus {
        case loading, done, error
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
