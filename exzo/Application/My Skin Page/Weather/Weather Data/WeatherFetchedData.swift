//
//  WeatherDataFetched.swift
//  WeatherAPITest
//
//  Created by Daniella Stefani on 08/11/21.
//

import Foundation

struct FetchedData: Codable {
    let name: String //city name
    let weather: [WeatherIcon]
    let main: WeatherData
}

struct WeatherIcon: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherData: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
}
