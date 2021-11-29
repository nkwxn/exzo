//
//  Constant.swift
//  WeatherAPITest
//
//  Created by Daniella Stefani on 08/11/21.
//

import Foundation
import CoreLocation

class Constant: NSObject {
    static func GET_WEATHER_CITY(
        name: String,
        apiKey: String = "0e6887936fd035827d0f5195a68a844c"
    ) -> String {
        if NSLocale.autoupdatingCurrent.identifier.hasSuffix("US") {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(name)&units=imperial&appid=\(apiKey)&lang=en"
        } else {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(name)&units=metric&appid=\(apiKey)&lang=id"
        }
    }
    
    static func GET_WEATHER_GEO(
        coordinate: CLLocationCoordinate2D,
        apiKey: String = "0e6887936fd035827d0f5195a68a844c"
    ) -> String {
        if NSLocale.autoupdatingCurrent.identifier.hasSuffix("US") {
            return "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=imperial&appid=\(apiKey)&lang=en"
        } else {
            return "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=metric&appid=\(apiKey)&lang=id"
        }
    }
}
