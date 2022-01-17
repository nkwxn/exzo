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
                Text("Memuat")
                ProgressView().progressViewStyle(.circular)
            }
            .onAppear {
                viewModel.checkLocationEnabled()
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 19)
                    .foregroundColor(Color.white)
                    .frame(width: 345, alignment: .center)
                    .padding()
                    .padding(.bottom, 15)
                    .shadow(color: Color.init(uiColor: UIColor.init(red: 0.45, green: 0.29, blue: 0.22, alpha: 0.2)), radius: 10, x: 2, y: 5)
            }
        case .done:
            HStack(alignment: .top, spacing: 10) {
                VStack {
                    Text(Image(systemName: "location")) + Text(viewModel.cityName)
                        .fontWeight(.medium)
                    AsyncImage(url: URL(string: viewModel.iconLink)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.weatherDesc)
//                        .font(.footnote)
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Text("Suhu")
                                .font(.footnote)
                            Text(viewModel.tempString)
                                .font(.title2)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Kelembapan")
                                .font(.footnote)
                            Text(viewModel.humidityString)
                                .font(.title2)
                        }
                    }
                    Text(viewModel.getMotivationKeyword())
                        .font(.subheadline).bold()
                        .multilineTextAlignment(.leading)
                    Text("Data disediakan oleh OpenWeather")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
            }
            .frame(width: 320, alignment: .center)
            .padding()
            .padding(.bottom, 15)
            .background {
                RoundedRectangle(cornerRadius: 19)
                    .foregroundColor(Color.white)
                    .frame(width: 345, alignment: .center)
                    .shadow(color: Color.init(uiColor: UIColor.init(red: 0.45, green: 0.29, blue: 0.22, alpha: 0.2)), radius: 10, x: 2, y: 5)
                    .padding(.bottom, 17)
            }
        case .error:
            Text("404 - Tidak Ditemukan")
        }
    }
}
