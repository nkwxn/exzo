//
//  JournalRowView.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import SwiftUI
import Lottie

struct JournalRowView: View {
    let journal: Journal
    let dummyData = Journals.journals
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 19)
                .foregroundColor(Color("accent_antique"))
                .frame(width: 347, height: 201, alignment: .center)
            VStack {
                HStack(alignment: .top) {
                    Text("13.00")
                        .padding()
                    Spacer()
                    Button("See details") {
                        print("see journal detail")
                    }
                    .padding()
                }
                Divider()
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Food Intake")
                                .font(.system(size: 11))
                            HStack {
                                ForEach((1...dummyData.foodIntake.count + 1), id: \.self) { index in
                                    if index > 1 {
                                        ZStack {
                                            Circle()
                                                .strokeBorder(Color.gray, lineWidth: 2)
                                                .background(Circle().foregroundColor(Color.green))
                                                .frame(width: 32, height: 32, alignment: .leading)
                                                .offset(x: CGFloat(-20 * index))
                                            Image(systemName: "a.circle")
                                                .offset(x: CGFloat(-20 * index))
//                                            Text("a")
//                                                .offset(x: CGFloat(-25 * index))
                                        }
                                    } else {
                                        Circle()
                                            .frame(width: 32, height: 32, alignment: .leading)
                                    }
                                }
                            }
                            .frame(width: 82, height: 32, alignment: .top)
                            .offset(x: CGFloat(-5 + 20 * (dummyData.foodIntake.count - 1)))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Exposure")
                                .font(.system(size: 11))
                            HStack {
                                ForEach((1...dummyData.skinExposure.count + 1), id: \.self) { index in
                                    if index > 1 {
                                        ZStack {
                                            Circle()
                                                .strokeBorder(Color.gray, lineWidth: 2)
                                                .background(Circle().foregroundColor(Color.orange))
                                                .frame(width: 32, height: 32, alignment: .leading)
                                                .offset(x: CGFloat(-20 * index))
                                            Text("b")
                                                .offset(x: CGFloat(-20 * index))
                                        }
                                    } else {
                                        Circle()
                                            .frame(width: 32, height: 32, alignment: .leading)
                                    }
                                }
                            }
                            .frame(width: 82, height: 32, alignment: .top)
                            .offset(x: CGFloat(-5 + 20 * (dummyData.skinExposure.count - 1)))
//                            Text("Bulet bulet")
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Activities")
                                .font(.system(size: 11))
                            HStack {
                                ForEach((1...dummyData.activities.count + 1), id: \.self) { index in
                                    if index > 1 {
                                        ZStack {
                                            Circle()
                                                .strokeBorder(Color.gray, lineWidth: 2)
                                                .background(Circle().foregroundColor(Color.blue))
                                                .frame(width: 32, height: 32, alignment: .leading)
                                                .offset(x: CGFloat(-20 * index))
                                            Text("c")
                                                .offset(x: CGFloat(-20 * index))
                                        }
                                    } else {
                                        Circle()
                                            .frame(width: 32, height: 32, alignment: .leading)
                                    }
                                }
                            }
                            .frame(width: 82, height: 32, alignment: .top)
                            .offset(x: CGFloat(-5 + 20 * (dummyData.activities.count - 1)))
//                            Text("Bulet bulet")
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("PO-Scorad")
                                .font(.system(size: 11))
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.accentColor)
                                    .frame(width: 32, height: 32, alignment: .center)
                                Text("\(dummyData.skinCondition.poScorad)")
                                    .bold()
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Stress Level")
                            .font(.system(size: 11))
                        ZStack {
                            Circle()
                                .foregroundColor(Color.accentColor)
                                .frame(width: 32, height: 32, alignment: .center)
                            Text("\(dummyData.stressLevel)")
                                .bold()
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                }
                .frame(width: 347, height: 117, alignment: .center)
            }
        }
        .frame(width: 347, height: 201, alignment: .center)
    }
}
