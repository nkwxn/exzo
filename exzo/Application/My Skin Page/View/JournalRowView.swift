//
//  JournalRowView.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import SwiftUI

struct JournalRowView: View {
    let journal: NewJournal
    let width = 300.0
    let accentArr = [Color.brandy, Color.copper, Color.accentYellow, Color.brandy]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 19)
                .foregroundColor(Color.white)
                .shadow(radius: 10)
            
            VStack {
                HStack(alignment: .top) {
                    Text(journal.dateAndTime!, style: .time)
                    Spacer()
                }
                Divider()
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Food Intake")
                                .font(.system(size: 11))
                            HStack(alignment: .center, spacing: -8) {
                                if let foodIntakes = journal.foodIntakes as? IEADatas {
                                    if foodIntakes.ieaDatas.isEmpty {
                                    } else {
                                        ForEach(0..<foodIntakes.ieaDatas.count, id: \.self) { idx in
                                            if idx < 4 {
                                                Image(foodIntakes.ieaDatas[idx].thumb)
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 32, height: 32, alignment: .center)
                                                    .background {
                                                        Circle()
                                                            .foregroundColor(accentArr[idx])
                                                            .frame(width: 32, height: 32, alignment: .center)
                                                            .shadow(radius: 2)
                                                    }
                                            }
                                        }
                                    }
                                } else {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(accentArr[1])
                                            .frame(width: 32, height: 32, alignment: .center)
                                            .shadow(radius: 2)
                                        Text("N/A")
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("PO Scorad")
                                .font(.system(size: 11))
                            ZStack {
                                Circle()
                                    .foregroundColor(accentArr[1])
                                    .frame(width: 32, height: 32, alignment: .center)
                                    .shadow(radius: 2)
                                Text("10")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Exposure")
                                .font(.system(size: 11))
                            HStack(alignment: .center, spacing: -8) {
                                if let exposure = journal.exposures {
                                    if exposure.ieaDatas.isEmpty {
                                        
                                    } else {
                                        ForEach(0..<exposure.ieaDatas.count, id: \.self) { idx in
                                            if idx < 4 {
                                                Image(exposure.ieaDatas[idx].thumb)
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 32, height: 32, alignment: .center)
                                                    .background {
                                                        Circle()
                                                            .foregroundColor(accentArr[idx])
                                                            .frame(width: 32, height: 32, alignment: .center)
                                                            .shadow(radius: 2)
                                                    }
                                            }
                                        }
                                    }
                                } else {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(accentArr[1])
                                            .frame(width: 32, height: 32, alignment: .center)
                                            .shadow(radius: 2)
                                        Text("N/A")
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Stress Level")
                                .font(.system(size: 11))
                            ZStack {
                                Circle()
                                    .foregroundColor(accentArr[1])
                                    .frame(width: 32, height: 32, alignment: .center)
                                    .shadow(radius: 2)
                                Text("\(String(format: "%.0f", journal.stressLevel))")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}
