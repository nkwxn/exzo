//
//  JournalDetailView.swift
//  exzo
//
//  Created by Daniella Stefani on 05/11/21.
//

import SwiftUI

struct JournalDetailView: View {
    @State var isEditing = false
    
    let journal: NewJournal
    let accentArr = [Color.brandy, Color.copper, Color.accentYellow, Color.brandy]
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(twoColumnsNavBar: true, title: "9 Oct 2021", subtitle: "09.00", showButton: .editButton) {
                isEditing.toggle()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Asupan makanan")
                    .font(Avenir(.headline).getFont().bold())
                HStack(alignment: .center) {
                    if let foodIntakes = journal.foodIntakes {
                        if foodIntakes.ieaDatas.isEmpty {
                            ZStack {
                                Circle()
                                    .foregroundColor(accentArr[1])
                                    .frame(width: 66, height: 66, alignment: .center)
                                    .shadow(radius: 2)
                                Text("N/A")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        } else {
                            ForEach(0..<foodIntakes.ieaDatas.count, id: \.self) { idx in
                                if idx < 4 {
                                    VStack {
                                        Image(foodIntakes.ieaDatas[idx].thumb)
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 66, height: 66, alignment: .center)
                                            .background {
                                                Circle()
                                                    .foregroundColor(accentArr[idx])
                                                    .frame(width: 66, height: 66, alignment: .center)
                                                    .shadow(radius: 2)
                                            }
                                        Text(foodIntakes.ieaDatas[idx].name)
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
            VStack(alignment: .leading, spacing: 5) {
                Text("Nilai stres")
                    .font(Avenir(.headline).getFont().bold())
                ZStack {
                    Circle()
                        .foregroundColor(accentArr[1])
                        .frame(width: 66, height: 66, alignment: .center)
                        .shadow(radius: 2)
                    Text("\(String(format: "%.0f", journal.stressLevel))")
                        .foregroundColor(.white)
                        .bold()
                }
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            VStack(alignment: .leading) {
                Text("Paparan")
                    .font(Avenir(.headline).getFont().bold())
                HStack(alignment: .center) {
                    if let exposure = journal.exposures {
                        if exposure.ieaDatas.isEmpty {
                            ZStack {
                                Circle()
                                    .foregroundColor(accentArr[1])
                                    .frame(width: 66, height: 66, alignment: .center)
                                    .shadow(radius: 2)
                                Text("N/A")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        } else {
                            ForEach(0..<exposure.ieaDatas.count, id: \.self) { idx in
                                if idx < 4 {
                                    VStack {
                                        Image(exposure.ieaDatas[idx].thumb)
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 66, height: 66, alignment: .center)
                                            .background {
                                                Circle()
                                                    .foregroundColor(accentArr[idx])
                                                    .frame(width: 66, height: 66, alignment: .center)
                                                    .shadow(radius: 2)
                                            }
                                        Text(exposure.ieaDatas[idx].name)
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
                Text("Produk")
                    .font(Avenir(.headline).getFont().bold())
                Text("Moisturizer - Somethinc")
                    .font(Avenir(.headline).getFont())
                Divider()
                Text("Kondisi kulit")
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
