//
//  JournalDetailView.swift
//  exzo
//
//  Created by Daniella Stefani on 05/11/21.
//

import SwiftUI

struct JournalDetailView: View {
    @State var isEditing = false
    
    let journal: Journal
    let accentArr = [Color.brandy, Color.copper, Color.accentYellow, Color.brandy]
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(twoColumnsNavBar: true, title: "9 Oct 2021", subtitle: "09.00", showButton: .editButton) {
                isEditing.toggle()
            }
            
            VStack(alignment: .leading) {
                Text("Food intake")
                    .font(Avenir(.headline).getFont().bold())
                HStack(alignment: .center) {
                    if let foodIntakes = journal.foodIntake as? [IEAData] {
                        if foodIntakes.isEmpty {
                        } else {
                            ForEach(0..<foodIntakes.count, id: \.self) { idx in
                                if idx < 4 {
                                    VStack {
                                        Image(foodIntakes[idx].thumb)
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 66, height: 66, alignment: .center)
                                            .background {
                                                Circle()
                                                    .foregroundColor(accentArr[idx])
                                                    .frame(width: 66, height: 66, alignment: .center)
                                                    .shadow(radius: 2)
                                            }
                                        Text(foodIntakes[idx].name)
                                            .font(Avenir(.caption).getFont())
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                        }
                    } else {
                        ZStack {
                            Circle()
                                .foregroundColor(accentArr[1])
                                .frame(width: 66, height: 66, alignment: .center)
                                .shadow(radius: 2)
                            Text("N/A")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Stress level")
                    .font(Avenir(.headline).getFont().bold())
                Text("\(journal.stressLevel)")
                    .font(Avenir(.title).getFont().bold())
                    .foregroundColor(Color.white)
                    .background {
                        Circle()
                            .frame(width: 66, height: 66)
                            .foregroundColor(Color.copper)
                        
                    }
                    .frame(width: 66, height: 66)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Exposure")
                    .font(Avenir(.headline).getFont().bold())
                HStack(alignment: .center) {
                    if let exposure = journal.skinExposure as? [IEAData] {
                        if exposure.isEmpty {
                            
                        } else {
                            ForEach(0..<exposure.count, id: \.self) { idx in
                                if idx < 4 {
                                    VStack {
                                        Image(exposure[idx].thumb)
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 66, height: 66, alignment: .center)
                                            .background {
                                                Circle()
                                                    .foregroundColor(accentArr[idx])
                                                    .frame(width: 66, height: 66, alignment: .center)
                                                    .shadow(radius: 2)
                                            }
                                        Text(exposure[idx].name)
                                            .font(Avenir(.caption).getFont())
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                        }
                    } else {
                        ZStack {
                            Circle()
                                .foregroundColor(accentArr[1])
                                .frame(width: 66, height: 66, alignment: .center)
                                .shadow(radius: 2)
                            Text("N/A")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Product")
                    .font(Avenir(.headline).getFont().bold())
                Text("Moisturizer - Somethinc")
                    .font(Avenir(.headline).getFont())
                Divider()
                Text("Skin conditions")
                    .font(Avenir(.headline).getFont().bold())
                VStack {
                    HStack {
                        Text("2")
                            .font(Lexend(.footnote).getFont().bold())
                            .foregroundColor(Color.white)
                            .background {
                                Circle()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(Color.copper)
                                
                            }
                            .frame(width: 32, height: 32)
                        Text("Dryness")
                            .font(Lexend(.footnote).getFont())
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}
