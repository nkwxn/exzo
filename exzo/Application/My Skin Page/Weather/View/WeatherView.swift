//
//  WeatherVie.swift
//  WeatherAPITest
//
//  Created by Daniella Stefani on 08/11/21.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        switch viewModel.fetchStatus {
        case .loading:
            VStack {
                Text("Loading")
                ProgressView().progressViewStyle(.circular)
                    .onAppear {
                        viewModel.checkLocationEnabled()
                    }
            }
        case .done:
            VStack {
                HStack {
                    AsyncImage(url: URL(string: viewModel.iconLink)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(viewModel.weatherDesc)
                            .font(.title3)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Temp")
                                Text(viewModel.tempString)
                                    .font(.body)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Humidity")
                                Text(viewModel.humidityString)
                                    .font(.body)
                            }
                        }
                        
                    }
                }
                Text(viewModel.recommendationString)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineLimit(0)
                Text("Weather data provided by OpenWeather")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: viewModel.loadWeather) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .padding(.horizontal)
        case .error:
            Text("404 not found")
        }
    }
}

