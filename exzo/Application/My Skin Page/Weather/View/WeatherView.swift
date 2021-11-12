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
        VStack(alignment: .center, spacing: 8) {
            Text("Today's Weather")
                .foregroundColor(.white)
                .font(Lexend(.title).getFont())
            switch viewModel.fetchStatus {
            case .loading:
                VStack {
                    Text("Loading")
                    ProgressView().progressViewStyle(.circular)
                        .onAppear {
                            viewModel.checkLocationEnabled()
                        }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 19)
                        .foregroundColor(Color.white)
                        .frame(width: 309, alignment: .center)
                        .shadow(color: Color.init(uiColor: UIColor.init(red: 0.45, green: 0.29, blue: 0.22, alpha: 0.2)), radius: 10, x: 2, y: 5)
                }
            case .done:
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: viewModel.iconLink)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 75, height: 75)
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
                        .lineLimit(3)
                    Text("Weather data provided by OpenWeather")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .padding()
    //            .toolbar {
    //                ToolbarItem(placement: .navigationBarTrailing) {
    //                    Button(action: viewModel.loadWeather) {
    //                        Image(systemName: "arrow.clockwise")
    //                    }
    //                }
    //            }
                .background {
                    RoundedRectangle(cornerRadius: 19)
                        .foregroundColor(Color.white)
                        .frame(width: 309, alignment: .center)
                        .shadow(color: Color.init(uiColor: UIColor.init(red: 0.45, green: 0.29, blue: 0.22, alpha: 0.2)), radius: 10, x: 2, y: 5)
                }
            case .error:
                Text("404 not found")
            }
        }
        .background {
            VStack {
                Image("NavBar-Background")
                    .cornerRadius(radius: 30, corners: .bottomLeft)
                    .cornerRadius(radius: 30, corners: .bottomRight)
                    .ignoresSafeArea(.all)
                Spacer()
            }
        }
    }
}

struct WeatherPreview: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
